class TimeLineItemsController < ApplicationController
  def index
    @time_line_items = TimeLineItem.all
  end

  def new

  end

  def create
    @time_line_item = TimeLineItem.new(time_line_item_params)

    if @time_line_item.save
      redirect_to @time_line_item
    else
      render 'new'
    end

  end

  def show
    @time_line_item = TimeLineItem.find(params[:id])
  end

  private
    def time_line_item_params
      params.require(:time_line_item).permit(:title, :subtitle)
    end
end
