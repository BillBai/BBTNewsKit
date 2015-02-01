class User < ActiveRecord::Base
  belongs_to :publisher
  
  has_many :contents, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum group: [ :contributor, :admin , :super_admin ]

  serialize :passed_ids

  def have_authority(action)
  	case action
  	when 'access_sections'
  	  if self.admin? or self.super_admin?
  	  	true
  	  else
  	  	false
  	  end
    when 'access_publishers'
      if self.admin? or self.super_admin?
        true
      else
        false
      end
    when 'manage_users'
      if self.super_admin?
        true
      else
        false
      end
    else
	     false
  	end
  end
end
