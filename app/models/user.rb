class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_and_belongs_to_many :stores, join_table: 'store_follow'

  def follow_store(store)
  	stores << store unless following_store?(store)
  end

  def unfollow_store(store)
  	stores.delete(store) if following_store?(store)
  end

  def following_store?(store)
  	stores.include? store
  end

  def admin?
    return ['superadmin', 'admin'].include?(self.user_type)
  end
end
