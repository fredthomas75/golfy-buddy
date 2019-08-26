class Game < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :guests, dependent: :destroy
  accepts_nested_attributes_for :attachments
  has_many :attachments, dependent: :destroy, as: :attachable
  mount_uploader :photo, PhotoUploader
end
