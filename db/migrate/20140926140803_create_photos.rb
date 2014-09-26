class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.string :photographer
      t.references :content, index: true

      t.timestamps
    end
  end
end
