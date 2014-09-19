class Section < ActiveRecord::Base
  has_many :articles
  has_many :videos

  enum category: [:news, :special, :weekly, :video]
end
