class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :wishgames, dependent: :destroy
  has_many :games, through: :wishgames
end
