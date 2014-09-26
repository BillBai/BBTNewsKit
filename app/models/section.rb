class Section < ActiveRecord::Base
  has_many :contents

  enum category: [:news, :special, :weekly, :video]
end
