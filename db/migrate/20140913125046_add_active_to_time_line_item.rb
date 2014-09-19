class AddActiveToTimeLineItem < ActiveRecord::Migration
  def change
    add_column :time_line_items, :active, :boolean
  end
end