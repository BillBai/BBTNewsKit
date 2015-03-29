class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_group
  layout false, only: [:test, :update]
  include ContentsHelper

  def check_group
    if params[:contributions]
      if not current_user.have_authority('view_all_contents')
        redirect_to contents_path
      end
    end
  end

  def index
    if params[:section_id]
      @section = Section.find(params[:section_id])
      @contents = @section.contents.where(delete_flag: false, parent_content_id: 0).order(:id).page params[:page]
    elsif params[:content_id]
      @content = Content.find(params[:content_id])
      @contents = @content.subcontents.where(delete_flag: false, parent_content_id: 0).order(:id).page params[:page]
    #srot by content_type
    elsif params[:content_type] && Content.content_types[params[:content_type]]
      if current_user.have_authority('view_all_contents')
        @contents = Content.where(["delete_flag = ? AND content_type = ? AND (publisher_id = ? OR passed_contribution = ?) AND parent_content_id = ?", false, Content.content_types[params[:content_type]], current_user.publisher_id, true, 0]).order(:id).page params[:page]
      elsif current_user.publisher_id == 0
        @contents = Content.where(delete_flag: false, user_id: current_user.id, passed_contribution: false, content_type: Content.content_types[params[:content_type]], parent_content_id: 0).order(:id).page params[:page]
      else
        @contents = Content.where(delete_flag: false, publisher_id: current_user.publisher_id, passed_contribution: false, content_type: Content.content_types[params[:content_type]], parent_content_id: 0).order(:id).page params[:page]
      end
    #view contributions(admin/super_admin only)
    elsif params[:contributions] == "true"
      @contents = Content.where(delete_flag: false, status: Content.statuses["pending"], parent_content_id: 0).order(:id).page params[:page]
    #all contents
    else
      if current_user.have_authority('view_all_contents')
        @contents = Content.where(["delete_flag = ? AND (publisher_id = ? OR passed_contribution = ?) AND parent_content_id = ?", false, current_user.publisher_id, true, 0]).order(:id).page params[:page]
      elsif current_user.publisher_id == 0
        @contents = Content.where(delete_flag: false, user_id: current_user.id, passed_contribution: false, parent_content_id: 0).order(:id).page params[:page]
      else
        @contents = Content.where(delete_flag: false, publisher_id: current_user.publisher_id, passed_contribution: false, parent_content_id: 0).order(:id).page params[:page]
      end
    end
  end

  def show
    if not current_user.can_view_content(params[:id])
      redirect_to contents_path
    end

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
    if not current_user.can_modify_content(params[:id])
      redirect_to contents_path
    end

    @content = Content.find(params[:id])
  end

  def update
    if not current_user.can_modify_content(params[:id])
      #can't access
      redirect_to contents_path
    end

    @content = Content.find(params[:id])

    if @content.update(content_params)
      #update template_html
      @host_url = request.protocol + request.host_with_port
      case @content.content_type
      when 'article'
        @content.template_html = get_mobile_html render_to_string('mobile_article')
      when 'album'
        @content.template_html = get_mobile_html render_to_string('mobile_album')
      end
      @content.save

      if params.include?('new') and params[:new] == "true"
        head :ok
        return
      end
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
      if params[:content_type] == 'special' && !current_user.have_authority('access_specials')
        redirect_to contents_path and return
      end
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

  def approve
    @content = Content.find(params[:id])
    @approved_content = Content.new
    @approved_content = @content.dup
    @approved_content.header_image = @content.header_image
    @approved_content.article_body_images = @content.article_body_images
    @approved_content.photos = @content.photos
    @approved_content.passed_contribution = true
    @approved_content.draft!
    @approved_content.save
    @content.approved!
    redirect_to action: 'show', id: @approved_content.id
  end


  def contribute
    @content = Content.find(params[:id])
    @content.pending!
    redirect_to action: 'show', id: @content.id
  end

  def focus
    @content = Content.find(params[:id])
    @content.on_focus = true
    @content.display_on_timeline = false
    @content.save
    redirect_to action: 'show', id: @content.id
  end

  def unfocus
    @content = Content.find(params[:id])
    @content.on_focus = false
    @content.display_on_timeline = true
    @content.save
    redirect_to action: 'show', id: @content.id
  end

  def test
    @host_url = request.protocol + request.host_with_port
    if params.include?('id')
      @content = Content.find(params[:id])
    else
      @content = Content.find(17)
    end
    #@html_string = render_to_string 'mobile_article'
    #render html: @html_string
    render html: @content.template_html.html_safe
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
