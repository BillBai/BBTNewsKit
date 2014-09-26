class AddAttrToArticleAndVideo < ActiveRecord::Migration
  def change
    add_column :contents, :title, :string
    add_column :contents, :subtitle, :string
    add_column :contents, :description, :string

    add_column :videos, :title, :string
    add_column :videos, :subtitle, :string
    add_column :videos, :description, :string
  end
end
