class AddBodyImageToArticleImage < ActiveRecord::Migration
  def change
    add_attachment :article_body_images, :body_image
  end
end
