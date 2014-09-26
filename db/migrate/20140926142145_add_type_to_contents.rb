class AddTypeToContents < ActiveRecord::Migration
  def change
    add_column :contents, :contentType, :integer
  end
end
