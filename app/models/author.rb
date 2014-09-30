class Author < ActiveRecord::Base
  has_many :contents

  enum department: [:admin_dept, :hr_dept, :news_dept,
                    :channel_dept, :video_dept, :market_dept,
                    :image_dept, :tech_dept, :design_dept, :pm_dept]
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
