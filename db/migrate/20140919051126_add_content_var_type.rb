class AddContentVarType < ActiveRecord::Migration
  def change
    add_column :contents, :content_variant_type, :string
  end
end
