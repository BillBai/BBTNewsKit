class ContentsController < ApplicationController
  def index
    @contents = Content.all
  end

  def show
    @content = Content.find(params[:id])
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(article_params)


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
    @content.destroy

    redirect_to contents_path
  end

private
  def content_params
    params.require(:content).permit(:title, :subtitle, :description, :author_id, :section_id, :header_image, :header_image_info, :body_html, :content_type, :status, :video_url)
  end
end
