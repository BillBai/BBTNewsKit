class PhotosController < ApplicationController
  def create
    @content = Content.find(params[:content_id])
    @photo = @content.photos.create(photo_params)
    redirect_to content_path(@content)
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :description, :photographer, :image)
  end
end
