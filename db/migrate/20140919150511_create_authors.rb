class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.integer :department
      t.string :name
      t.string :display_name

      t.timestamps
    end
  end
end
