class ArticleBodyImagesController < ApplicationController
  # TODO: security issue
  def create
    @article_body_image = ArticleBodyImage.create(article_body_image_params)
    render json: @article_body_image.body_image.url(:medium)
  end

  def destroy

  end

private
  def article_body_image_params
    {body_image: params[:file]}
  end
end
