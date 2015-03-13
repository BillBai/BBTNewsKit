class AddAttrToContents < ActiveRecord::Migration
  def change
  	add_column :contents, :passed_contribution, :boolean, default: false
  end
end
