class SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_group

  def index
    @sections = Section.all
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      redirect_to @section
    else
      render 'new'
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Author.find(params[:id])

    if @section.update(section_params)
      redirect_to @section
    else
      render 'edit'
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    redirect_to sections_path
  end

  private
  def section_params
    params.require(:section).permit(:category, :module)
  end

  def check_group
    if not current_user.admin?
      #have no right to access sections
      redirect_to contents_path
    end
  end
end
