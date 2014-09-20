class AddheaderImageToArticle < ActiveRecord::Migration
  def change
    add_attachment :articles, :header_image
    add_column :articles, :header_image_info, :string
  end

end
