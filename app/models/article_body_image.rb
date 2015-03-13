class ArticleBodyImage < ActiveRecord::Base
  belongs_to :content
  #has_attached_file :body_image
  has_attached_file :body_image, :styles => { :medium => "80%"}
  validates_attachment_content_type :body_image, :content_type => /\Aimage\/.*\Z/
end
