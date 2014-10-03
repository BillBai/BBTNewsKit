class ChangeDefaultValue < ActiveRecord::Migration
  def change
    change_column :contents, :delete_flag, :boolean, :default => false
  end
end
