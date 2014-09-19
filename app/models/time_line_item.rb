class TimeLineItem < ActiveRecord::Base
  enum content_type: [:article, :album, :video]

  validates :title, presence: true,
            length: {minimum:  3, maximum: 12}
end
