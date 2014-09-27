class Content < ActiveRecord::Base
  belongs_to :author
  belongs_to :section

  has_many :article_body_images
  has_many :photos

  enum status: [:draft, :published]
  enum content_type: [:article, :album, :video]

  has_attached_file :header_image, :styles => { :medium => "500x300>", :thumb => "100x60>" }
  validates_attachment_content_type :header_image, :content_type => /\Aimage\/.*\Z/

  def self.default_content_params(content_type = :article)
    {
        :title => 'default title',
        :subtitle => 'default subtitle',
        :description => 'default description',
        :content_type => Content.content_types[content_type],
        :status => Content.statuses[:draft],
    }
  end
end
