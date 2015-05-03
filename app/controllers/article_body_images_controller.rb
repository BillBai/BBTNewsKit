require 'cgi'

class ArticleBodyImagesController < ApplicationController
  # TODO: security issue
  def create
    @article_body_image = ArticleBodyImage.new(article_body_image_params)
    @content = Content.find(params[:content_id])
    @article_body_image.content = @content
    @article_body_image.save
    p '=================================='
    p json: body_image_url_with_id
    render json: body_image_url_with_id, :status => 200
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
    host_url = request.protocol + request.host_with_port
    host_url + "#{@article_body_image.body_image.url(:original)}?id=#{@article_body_image.id}"
  end
end
