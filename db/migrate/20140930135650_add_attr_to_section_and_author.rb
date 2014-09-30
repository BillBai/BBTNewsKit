class AddAttrToSectionAndAuthor < ActiveRecord::Migration
  def change
  	add_attachment :authors, :avatar
  	add_attachment :sections, :section_image
  end
end
