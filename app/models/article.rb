class Article < ActiveRecord::Base
  has_one :content, as: :content_variant
end
