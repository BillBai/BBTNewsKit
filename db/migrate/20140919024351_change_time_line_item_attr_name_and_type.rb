class ChangeTimeLineItemAttrNameAndType < ActiveRecord::Migration
  def change
    change_column :time_line_items, :contentType, :integer, default: 0
    rename_column :time_line_items, :contentType, :content_type
    rename_column :time_line_items, :contentId, :content_id
    rename_column :time_line_items, :contentURL, :content_url
  end
end
