class AddReferencesToArticleAndVideo < ActiveRecord::Migration
  def change
    add_column :contents, :author_id, :integer
    add_column :contents, :section_id, :integer

    add_column :videos, :author_id, :integer
    add_column :videos, :section_id, :integer

  end
end
