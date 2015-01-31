class CrentePublisherAgain < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :name

      t.timestamps
    end
    add_column :publishers, :active, :boolean, default: true
    add_column :contents, :publisher_id, :integer
  end
end
