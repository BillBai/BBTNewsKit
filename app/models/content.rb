class Content < ActiveRecord::Base
  belongs_to :time_line_item
  belongs_to :content_variant, polymophic: true
end
