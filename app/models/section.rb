class Section < ActiveRecord::Base
  has_many :contents

  enum category: [:news, :special, :weekly, :video]

  has_attached_file :section_image, :styles => { :medium => "300x300>"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :section_image, :content_type => /\Aimage\/.*\Z/
end
