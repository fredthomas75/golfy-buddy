class Game < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :guests, dependent: :destroy
  mount_uploader :photo, PhotoUploader
end
