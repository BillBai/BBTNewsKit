class CreateArticleBodyImages < ActiveRecord::Migration
  def change
    create_table :article_body_images do |t|

      t.timestamps
    end
  end
end
