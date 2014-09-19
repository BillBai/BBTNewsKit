class ChangeContentTypeToInteger < ActiveRecord::Migration
  def change
    change_column :time_line_items, :content_type, :integer
  end
end
