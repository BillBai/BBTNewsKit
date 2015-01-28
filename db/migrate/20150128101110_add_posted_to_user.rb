class AddPostedToUser < ActiveRecord::Migration
  def change
  	add_column :users, :passed_id, :integer, array: true, default: []
  end
end
