class FixupUser4 < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  	  t.remove :passed_ids
  	end

  	add_column :users, :passed_ids, :integer, default: [].to_yaml
  end
end
