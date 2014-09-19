class TimeLineItemsController < ApplicationController
  def index
    @time_line_items = TimeLineItem.all
  end

  def new
    @time_line_item = TimeLineItem.new
  end



  def show
    @time_line_item = TimeLineItem.find(params[:id])
  end

  def edit
    @time_line_item = TimeLineItem.find(params[:id])
  end

  def create
    @time_line_item = TimeLineItem.new(time_line_item_params)

    if @time_line_item.save
      redirect_to @time_line_item
    else
      render 'new'
    end
  end

  def update
    @time_line_item = TimeLineItem.find(params[:id])

    if @time_line_item.update(time_line_item_params)
      redirect_to @time_line_item
    else
      render 'edit'
    end
  end

  def destroy
    @time_line_item = TimeLineItem.find(params[:id])
    @time_line_item.destroy

    redirect_to time_line_items_path
  end




  private
    def time_line_item_params
      params.require(:time_line_item).permit(:title, :subtitle)
    end
end
