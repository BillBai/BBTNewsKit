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

  def self.getList(from,limit)
    had_from_id = false
    if(from == '')
      from_id = Content.last.id
    else
      had_from_id = true
      from_id = from
    end

    count = 0
    from_id_count = 0
    id = from_id
    list = Array.new

     loop do
        if (Content.exists?(id) && Content.find(id).status == 'published' && Content.find(id).delete_flag ==nil)
          list << getListItem(id)
          count = count + 1
        end
        from_id_count = from_id_count + 1
        id = id - 1
        break if (id < 0 || count == limit  || (had_from_id && from_id_count == limit))
      end

      return list
  end

  private
  def self.getListItem(id)
    content = Content.find(id)
    item = Hash[
      "id" => content.id,
      "content_type" => content.content_type,
      "created_at" => content.created_at,
      "updated_at" => content.updated_at,
      "title" => content.title,
      "subtitle" => content.subtitle,
      "description" => content.description,
      "author_id" => content.author_id,
      "section_id" => content.section_id,
      "trumb_image_url" => nil
    ]
    return item
  end
end
