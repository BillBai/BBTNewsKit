class PublishersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_group

  def index
    @publishers = Publisher.all
  end

  def show
    @publisher = Publisher.find(params[:id])
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(publisher_params)

    if @publisher.save
      redirect_to @publisher
    else
      render 'new'
    end
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def update
    @publisher = Publisher.find(params[:id])

    if @publisher.update(publisher_params)
      redirect_to @publisher
    else
      render 'edit'
    end
  end

  def destroy
    @publisher = Publisher.find(params[:id])
    @publisher.destroy

    redirect_to publishers_path
  end

  private
  def publisher_params
    params.require(:publisher).permit(:name)
  end

  def check_group
    if not current_user.admin?
      #have no right to access sections
      redirect_to contents_path
    end
  end
end
