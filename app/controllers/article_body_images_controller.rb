require 'cgi'

class ArticleBodyImagesController < ApplicationController
  # TODO: security issue
  def create
    @article_body_image = ArticleBodyImage.new(article_body_image_params)
    @content = Content.find(params[:content_id])
    @article_body_image.content = @content
    @article_body_image.save
    render json: body_image_url_with_id
  end

  def destroy
    body_image_id = CGI::parse(params[:file]).values.first.first
    @article_body_image = ArticleBodyImage.find(body_image_id)
    if @article_body_image
      @article_body_image.body_image = nil
      @article_body_image.destroy
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 204
    end
  end

private
  def article_body_image_params
    {body_image: params[:file]}
  end

  def body_image_url_with_id
    "#{@article_body_image.body_image.url(:medium)}?id=#{@article_body_image.id}"
  end
end
