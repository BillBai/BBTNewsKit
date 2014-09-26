class Author < ActiveRecord::Base
  has_many :contents

  enum department: [:admin_dept, :hr_dept, :news_dept,
                    :channel_dept, :video_dept, :market_dept,
                    :image_dept, :tech_dept, :design_dept, :pm_dept]
end
