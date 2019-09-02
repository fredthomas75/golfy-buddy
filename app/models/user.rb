class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :games, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :user_preferences, dependent: :destroy
  has_many :list_prefs, through: :user_preferences
  mount_uploader :photo, PhotoUploader
  # messageable = this Class can use mailboxer gem
  acts_as_messageable
  has_friendship

  validates :gender, presence: true

  def in_game?(game)
    Guest.find_by(user: self, game: game)
  end
end
