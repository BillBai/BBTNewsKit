class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :category
      t.string :module

      t.timestamps
    end
  end
end
