class RemoveAuthorIdFromContents < ActiveRecord::Migration
  def change
  	remove_column :contents, :author_id
  end
end
