class FixupUser3 < ActiveRecord::Migration
  def change
  	add_column :users, :passed_ids, :integer
  end
end
