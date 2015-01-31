class Publisher < ActiveRecord::Base
  has_many :contents
  has_many :users
end
