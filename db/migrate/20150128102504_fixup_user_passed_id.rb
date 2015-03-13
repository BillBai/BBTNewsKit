class FixupUserPassedId < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  	  t.remove :passed_id
  	  t.integer :passed_id, array: true, default: []
  	end
  end
end
