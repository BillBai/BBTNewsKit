class ContentsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:section_id]
      @section = Section.find(params[:section_id])
      @contents = @section.contents.where(delete_flag: false).order(:id).page params[:page]
    elsif params[:content_id]
      @content = Content.find(params[:content_id])
      @contents = @content.subcontents.where(delete_flag: false).order(:id).page params[:page]
    elsif params[:content_type] && Content.content_types[params[:content_type]]
      @contents = Content.where(delete_flag: false, content_type: Content.content_types[params[:content_type]]).order(:id).page params[:page]
    else
      @contents = Content.where(delete_flag: false).order(:id).page params[:page]
    end
  end

  def show
    @content = Content.find(params[:id])
    if @content.special?
      render 'show_special'
    else
      render 'show'
    end
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)

    if @content.save
      redirect_to @content
    else
      render 'new'
    end
  end

  def edit
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])

    if @content.update(content_params)
      if @content.parent_content_id != 0 # a sub content, return to its parent page
        redirect_to action: 'edit', id: @content.parent_content
      else
        redirect_to @content # a root content
      end
    else
      render 'edit'
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @content.archive

    redirect_to contents_path
  end

  def add
    if Content.content_types[params[:content_type]]
      @content = Content.create(Content.default_content_params(current_user,params[:content_type]))
    else
      @content = Content.create(Content.default_content_params(current_user))
    end

    # if the content to be added is a subcontent to a Content (say a special)
    if params[:content_id]
      @content.parent_content = Content.find(params[:content_id])
      @content.display_on_timeline = false # the sub content will not display on time line by default
      @content.save
    end
    redirect_to action: 'edit', id: @content.id
  end

  def publish
    @content = Content.find(params[:id])
    @content.published!
    redirect_to action: 'show', id: @content.id
  end

  def revoke
    @content = Content.find(params[:id])
    @content.draft!
    redirect_to action: 'show', id: @content.id
  end

  def contribute
    @content = Content.find(params[:id])
    @content.pending!
    redirect_to action: 'show', id: @content.id
  end

private
  def content_params
    params.require(:content).permit(:title,
                                    :subtitle,
                                    :description,
                                    :author_id,
                                    :section_id,
                                    :user_id,
                                    :header_image,
                                    :header_image_info,
                                    :body_html,
                                    :video_url)
  end
end
