class AddBodyHtmlToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :body_html, :text
  end
end
