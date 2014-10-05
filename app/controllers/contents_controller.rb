class ContentsController < ApplicationController
  def index
    if params[:section_id]
      @section = Section.find(params[:section_id])
      @contents = @section.contents.where(delete_flag: false).order(:id).page params[:page]
    else
      @contents = Content.where(delete_flag: false).order(:id).page params[:page]
    end
  end

  def show
    @content = Content.find(params[:id])
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
      redirect_to @content
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
      @content = Content.create(Content.default_content_params(params[:content_type]))
    else
      @content = Content.create(Content.default_content_params)
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

private
  def content_params
    params.require(:content).permit(:title, :subtitle, :description, :author_id, :section_id, :header_image, :header_image_info, :body_html, :video_url)
  end
end
