class ChangeContentsReferences < ActiveRecord::Migration
  def change
    rename_column :article_body_images, :article_id, :content_id
  end
end
