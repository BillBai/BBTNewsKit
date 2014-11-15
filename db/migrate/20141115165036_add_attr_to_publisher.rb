class AddAttrToPublisher < ActiveRecord::Migration
  def change
    add_column :publishers, :active, :boolean, default: true
  end
end
