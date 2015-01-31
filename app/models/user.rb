class User < ActiveRecord::Base
  belongs_to :publisher
  
  has_many :contents, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum group: [ :contributor, :admin ]

  serialize :passed_ids
end
