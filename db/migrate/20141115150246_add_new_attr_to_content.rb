class AddNewAttrToContent < ActiveRecord::Migration
  def change
    add_column :contents, :parent_content, :integer, default: 0
    add_column :contents, :on_focus, :boolean, default: false
    add_column :contents, :display_on_timeline, :boolean, default: true
  end
end
