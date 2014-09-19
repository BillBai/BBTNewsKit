class Author < ActiveRecord::Base
  has_many :articles
  has_many :videos
end
