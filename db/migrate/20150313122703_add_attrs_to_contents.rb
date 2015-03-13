class AddAttrsToContents < ActiveRecord::Migration
  def change
  	add_column :contents, :views, :integer, default: 0
  	add_column :contents, :like, :integer, default: 0
  end
end
