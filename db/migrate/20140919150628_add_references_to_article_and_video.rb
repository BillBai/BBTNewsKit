class AddReferencesToArticleAndVideo < ActiveRecord::Migration
  def change
    add_column :articles, :author_id, :integer
    add_column :articles, :section_id, :integer

    add_column :videos, :author_id, :integer
    add_column :videos, :section_id, :integer

  end
end
