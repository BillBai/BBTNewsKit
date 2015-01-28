class FixupUser2 < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  	  t.remove :passed_ids
  	end
  end
end
