class SetDefaultValues < ActiveRecord::Migration
  def change
    change_column :contents, :status, :integer, defaulf: 0
    change_column :contents, :delete_flag, :boolean, defaulf: false
    change_column :sections, :active, :boolean, default: true
    change_column :authors, :active, :boolean, default: true
  end
end
