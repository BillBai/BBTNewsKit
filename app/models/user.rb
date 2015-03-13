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
    when 'manage'
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
    when 'publish'
      if self.admin? or self.super_admin?
        true
      else
        false
      end
    when 'view_all_contents'
      if self.admin? or self.super_admin?
        true
      else
        false
      end
    when 'access_specials'
      if self.admin? or self.super_admin?
        true
      else
        false
      end
    else
	     false
  	end
  end

  def can_modify_content(content_id)
    @content = Content.find(content_id)
    if self.admin? || self.super_admin?
      if (@content.publisher_id == self.publisher_id && !(@content.pending?)) || @content.passed_contribution?
        true
      else
        false
      end
    else
      if @content.user_id == self.id && !(@content.approved? || @content.pending?)
        true
      else
        false
      end
    end
  end

  def can_view_content(content_id)
    @content = Content.find(content_id)
    if self.admin? || self.super_admin?
      if @content.publisher_id == self.publisher_id || @content.pending? || @content.passed_contribution?
        true
      else
        false
      end
    else
      if @content.user_id == self.id
        true
      else
        false
      end
    end
  end
end
