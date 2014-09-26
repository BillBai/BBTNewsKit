class Photo < ActiveRecord::Base
  belongs_to :content

  has_attached_file :image, :styles => { :medium => "800x500>", :thumb => "160x90>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
