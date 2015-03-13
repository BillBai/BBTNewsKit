class FixupUserAtr < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  	  t.remove :group
  	  t.column :group, :integer, default: 0
  	end
  end
end
