class AddArticleReferenceToArticleBodyImage < ActiveRecord::Migration
  def change
    add_column :article_body_images, :article_id, :integer
  end
end
