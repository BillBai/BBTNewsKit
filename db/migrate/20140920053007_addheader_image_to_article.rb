class AddheaderImageToArticle < ActiveRecord::Migration
  def change
    add_attachment :contents, :header_image
    add_column :contents, :header_image_info, :string
  end

end
