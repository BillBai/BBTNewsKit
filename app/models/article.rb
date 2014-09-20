class Article < ActiveRecord::Base
  belongs_to :author
  belongs_to :section

  has_many :article_body_images

  has_attached_file :header_image, :styles => { :medium => "500x300>", :thumb => "100x60>" }
  validates_attachment_content_type :header_image, :content_type => /\Aimage\/.*\Z/
end
