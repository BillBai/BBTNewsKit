class ChangeAttOfUser < ActiveRecord::Migration
  def change
  	change_column :users, :publisher_id, :integer, default: 0
  end
end
