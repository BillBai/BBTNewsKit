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

  def self.get_list(from_id,limit)
    if(from_id == '')
      temp = Content.where('delete_flag' => nil,'status' => 1).last(limit)
    else
      if(from_id - limit < 0)
        offset = 0
        @limit = from_id
      else
        offset = from_id - limit
        @limit = limit
      end
      temp = Content.limit(@limit).offset(offset)
    end
    return get_list_item(temp)
  end

  private
  def self.get_list_item(content_array)
    list = Array.new
    content_array.each do |content|
      if(content.delete_flag != nil || content.status != 'published')
        next
      end
      author = Author.find(content.author_id)
      section = Section.find(content.section_id)
      item = Hash[
        "id" => content.id,
        "title" => content.title,
        "subtitle" => content.subtitle,
        "description" => content.description,
        "content_type" => content.content_type,
        "author" => Hash["name" => author.name , "display_name" => author.display_name , "department" => author.department],
        "section" => Hash["category" => section.category,"module" => section.module],
        "created_at" => content.created_at,
        "updated_at" => content.updated_at,
        "trumb_image_url" => nil,
      ]
      list << item
    end
    return list
  end

  public
  def get_detail
    author = Author.find(self.author_id)
    section = Section.find(self.section_id)
    item = Hash[
      "id" => self.id,
      "title" => self.title,
      "subtitle" => self.subtitle,
      "description" => self.description,
      "content_type" => self.content_type,
      "author" => Hash["name" => author.name , "display_name" => author.display_name , "department" => author.department],
      "section" => Hash["category" => section.category,"module" => section.module],
      "created_at" => self.created_at,
      "updated_at" => self.updated_at,
      "trumb_image_url" => nil,
      "body_html" => self.body_html,
      "video_url" => self.video_url,
      "photos" => self.photos
    ]
  end

  def self.get_contents_by_section(id)
    temp = Content.where('delete_flag' => nil,'status' => 1,'section_id' => id)
    return get_list_item(temp)
  end
end
