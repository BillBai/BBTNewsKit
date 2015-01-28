class FixupUserBug < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  	  t.remove :passed_id
  	end
  	add_column :users, :passed_ids, :integer, array: true, default: []
  end
end
