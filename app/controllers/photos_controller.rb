class PhotosController < ApplicationController

  def index
    @content = Content.find(params[:content_id])

    respond_to do |format|
      format.json {render json: @content.photos.map {|photo| photo.to_jq_photo}}
    end
  end

  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @photo }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /uploads/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @content = Content.find(params[:content_id])
    @photo = @content.photos.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html {
          render :json => [@photo.to_jq_photo].to_json,
                 :content_type => 'text/html',
                 :layout => false
        }
        format.json { render json: {files: [@photo.to_jq_photo]}, status: :created, location: content_photo_path(@content, @photo) }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(photo_params)
        format.html { redirect_to @photo, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to content_photo_url(@photo) }
      format.json { head :no_content }
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :description, :photographer, :image)
  end
end
