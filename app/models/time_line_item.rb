class TimeLineItem < ActiveRecord::Base
  has_one :content

  enum content_type: [:article, :album, :video]

  validates :title, presence: true,
            length: {minimum:  3, maximum: 12}
end
