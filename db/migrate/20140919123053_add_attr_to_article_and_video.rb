class AddAttrToArticleAndVideo < ActiveRecord::Migration
  def change
    add_column :articles, :title, :string
    add_column :articles, :subtitle, :string
    add_column :articles, :description, :string

    add_column :videos, :title, :string
    add_column :videos, :subtitle, :string
    add_column :videos, :description, :string
  end
end
