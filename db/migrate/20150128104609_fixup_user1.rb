class FixupUser1 < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  	  t.remove :passed_ids
  	  t.integer :passed_ids, :array => true, default: []
  	end
  end
end
