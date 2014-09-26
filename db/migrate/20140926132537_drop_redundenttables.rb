class DropRedundenttables < ActiveRecord::Migration
  def change
    drop_table :videos
    drop_table :contents
    drop_table :time_line_items
    rename_table :articles, :contents
  end
end
