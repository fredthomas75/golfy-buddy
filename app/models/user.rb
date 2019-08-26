class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :games
  mount_uploader :photo, PhotoUploader
  # messageable = this Class can use mailboxer gem
  acts_as_messageable
  has_many :one_user, :class_name => 'Buddu', :foreign_key => 'one_user_id'
  has_many :two_user, :class_name => 'Buddy', :foreign_key => 'two_user_id'
  has_many :last_action_user, :class_name => 'Buddy', :foreign_key => 'last_action_user_id'
end
