class Photo < ActiveRecord::Base
  belongs_to :content

  has_attached_file :image, :styles => { :medium => "800x500>", :thumb => "160x90>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def to_jq_photo
    {
        "name" => read_attribute(:image_file_name),
        "size" => read_attribute(:image_file_size),
        "url" => self.image.url(:medium),
        'thumbnail_url' => self.image.url(:thumb),
        'title' => self.title,
        'description' => self.description,
        'photographer' => self.photographer,
        "delete_url" => Rails.application.routes.url_helpers.content_photo_path(self.content, self),
        "delete_type" => "DELETE"
    }
  end
end
