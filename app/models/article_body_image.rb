class ArticleBodyImage < ActiveRecord::Base
  belongs_to :content, dependent: :destroy
  has_attached_file :body_image, :styles => { :medium => "500x400>"}
  validates_attachment_content_type :body_image, :content_type => /\Aimage\/.*\Z/
end
