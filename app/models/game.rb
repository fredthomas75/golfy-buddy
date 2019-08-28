class Game < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments
  validates :number_players, presence: true
end
