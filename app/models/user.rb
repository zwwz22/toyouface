class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :password, :password_confirmation
  has_many :focus_users ,:through => :relationships
  has_many :relationships ,:foreign_key => 'be_focus_user_id',:dependent => :destroy
  has_many :be_focus_users, :through => :reverse_relationships
  has_many :reverse_relationships ,:foreign_key => 'focus_user_id',:class_name => "Relationship" ,:dependent => :destroy

  has_many :collection_users,:through => :collection_relationships
  has_many :collection_relationships ,:foreign_key => 'be_collection_user_id',:dependent => :destroy
  has_many :be_collection_users,:through => :reverse_collection_relationships
  has_many :reverse_collection_relationships,:foreign_key => 'collection_user_id',:class_name => 'CollectionRelationship',:dependent => :destroy

  scope :order_desc,order('id desc')

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def add_a
    p '1111'
  end


  #def password
  #  @password
  #end
  #
  #def password=(pass)
  #  return unless pass
  #  @password = pass
  #  generate_password(pass)
  #end
  #
  #
  ## 此处用动词形式(authenticate)更加合适, 特此说明一下. 感谢 Chen Kai 同学的提醒.
  #def self.authentication(login, password)
  #  user = User.find_by_login(login)
  #  if user && Digest::SHA256.hexdigest(password + user.salt) == user.hashed_password
  #    return user
  #  end
  #  false
  #end
  #
  #private
  #def generate_password(pass)
  #  salt = Array.new(10){rand(1024).to_s(36)}.join
  #  self.salt, self.hashed_password =
  #      salt, Digest::SHA256.hexdigest(pass + salt)
  #end

end
