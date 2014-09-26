class AddBodyHtmlToArticle < ActiveRecord::Migration
  def change
    add_column :contents, :body_html, :text
  end
end
