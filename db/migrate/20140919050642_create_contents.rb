class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :subtitle
      t.string :description
      t.references :content_variant, polymorphic: true

      t.timestamps
    end
  end
end
