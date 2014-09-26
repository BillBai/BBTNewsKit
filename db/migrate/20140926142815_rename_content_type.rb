class RenameContentType < ActiveRecord::Migration
  def change
    rename_column :contents, :contentType, :content_type
  end
end
