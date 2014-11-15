class RenameParentContentReferences < ActiveRecord::Migration
  def change
    rename_column :contents, :parent_content, :parent_content_id
  end
end
