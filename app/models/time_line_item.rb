class TimeLineItem < ActiveRecord::Base
  validates :title, presence: true,
            length: {minimum:  3, maximum: 12}
end
