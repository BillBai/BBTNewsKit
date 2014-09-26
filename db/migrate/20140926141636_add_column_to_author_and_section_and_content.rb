class AddColumnToAuthorAndSectionAndContent < ActiveRecord::Migration
  def change
    add_column :authors, :active, :boolean
    add_column :sections, :active, :boolean
    add_column :contents, :status, :integer
    add_column :contents, :delete_flag, :boolean
  end
end
