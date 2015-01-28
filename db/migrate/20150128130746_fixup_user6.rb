class FixupUser6 < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  	  t.remove :passed_ids
  	end

  	add_column :users, :passed_ids, :integer
  end
end
