class Photo < ActiveRecord::Base
  belongs_to :content

  has_attached_file :image, :styles => { :medium => "1600x900>", :thumb => "160x90>" }
end
