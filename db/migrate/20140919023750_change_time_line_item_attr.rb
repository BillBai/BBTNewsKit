class ChangeTimeLineItemAttr < ActiveRecord::Migration
  def change
    change_column :time_line_items, :contentType, :integer
  end
end
