class Content < ActiveRecord::Base
  belongs_to :author
  belongs_to :section
  belongs_to :publisher

  has_many :article_body_images, dependent: :destroy
  has_many :photos, dependent: :destroy

  has_many :subcontents, class_name: 'Content', foreign_key: 'parent_content_id'
  belongs_to :parent_content, class_name: 'Content'

  enum status: [:draft, :wating_for_review, :approved, :rejected, :published, :dead]
  enum content_type: [:article, :album, :video, :special]

  has_attached_file :header_image, :styles => { :medium => "500x300>", :thumb => "100x60>" }
  validates_attachment_content_type :header_image, :content_type => /\Aimage\/.*\Z/

  paginates_per 23

  public
  def self.default_content_params(content_type = :article)
      { :title => 'default title',
        :subtitle => 'default subtitle',
        :description => 'default description',
        :content_type => Content.content_types[content_type],
        :status => Content.statuses[:draft],
        :section_id => 0,
        :author_id => 0,
        :publisher_id => 0
      }
  end

  def self.get_list(limit,max_id,since_id,on_focus,on_timeline,content_type)
    if content_type != nil
      temp = Content.where(content_type: Content.content_types[content_type],on_focus: on_focus,display_on_timeline: on_timeline, delete_flag: false, status: Content.statuses[:published],id: since_id..max_id).last(limit)
    else
      temp = Content.where(on_focus: on_focus,display_on_timeline: on_timeline, delete_flag: false, status: Content.statuses[:published],id: since_id..max_id).last(limit)
    end
    return get_list_item(temp)
  end

  def get_detail
    #author = Author.find(self.author_id)
    #section = Section.find(self.section_id)
    item = full_hash_for_api
  end

  def self.get_subcontents(parent_content_id)
    content_arr = Content.find(parent_content_id).subcontents.where(delete_flag:  false, status: Content.statuses[:published])
    return get_list_item(content_arr)
  end

  def self.get_focus
    temp = Content.where(delete_flag: false, status: Content.statuses[:published], on_focus: true).last(5)
    return get_list_item(temp)
  end

  def self.get_contents_by_section(id,limit,max_id,since_id,content_type)
    if content_type != nil
      temp = Content.where(content_type: Content.content_types[content_type],section_id: id, display_on_timeline: true, delete_flag: false, status: Content.statuses[:published],id: since_id..max_id).last(limit)
    else
      temp = Content.where(section_id: id, display_on_timeline: true, delete_flag: false, status: Content.statuses[:published],id: since_id..max_id).last(limit)
    end
    return get_list_item(temp)
  end

  def self.get_contents_by_publisher(pid,limit,max_id,since_id,content_type)
    if content_type != nil
      temp = Content.where(content_type: Content.content_types[content_type],publisher_id: pid,display_on_timeline: true, delete_flag: false, status: Content.statuses[:published],id: since_id..max_id).last(limit)
    else
      temp = Content.where(publisher_id: pid,display_on_timeline: true, delete_flag: false, status: Content.statuses[:published],id: since_id..max_id).last(limit)
    end
    return get_list_item(temp)
  end

  def full_hash_for_api
    {
        id: self.id,
        title: self.title,
        subtitle: self.subtitle,
        publisher: self.publisher,
        description: self.description,
        content_type: self.content_type,
        author: {id: self.author.id, name: author.name, display_name: author.display_name, department: author.department},
        section: {id: self.section.id, category: section.category, module: section.module},
        created_at: self.created_at,
        updated_at: self.updated_at,
        trumb_image_url: self.header_image.url(:thumb),
        body_html: self.body_html,
        video_url: self.video_url,
        photos: Content.get_photos(self.photos)
    }
  end

  def reduced_hash_for_api
    {
        id: self.id,
        title: self.title,
        subtitle: self.subtitle,
        publisher: self.publisher,
        description: self.description,
        content_type: self.content_type,
        author: {id: self.author.id, name: self.author.name, display_name: self.author.display_name, department: self.author.department},
        section: {id: self.section.id, category: self.section.category, module: self.section.module},
        created_at: self.created_at,
        updated_at: self.updated_at,
        trumb_image_url: self.header_image.url(:thumb),
        on_focus: self.on_focus,
        display_on_timeline: self.display_on_timeline
    }
  end

  def archive
    self.update_attributes!(delete_flag: true)
  end
  
  private
    def self.get_list_item(content_array)
      list = Array.new
      content_array.each do |content|
        #author = Author.find(content.author_id)
        #section = Section.find(content.section_id)
        item = content.reduced_hash_for_api
        list << item
      end
      return list
    end

  private
    def self.get_photos(photos_array)
      list = Array.new
      photos_array.each do |photo|
        list << {
            id: photo.id,
            title: photo.title,
            description: photo.description,
            photographer: photo.photographer,
            created_at: photo.created_at,
            image_file_size: photo.image_file_size,
            image_url: photo.image.url(:medium)
        }
      end
      return list
    end 

end
