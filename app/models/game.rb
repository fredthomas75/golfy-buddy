class Game < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :likes, dependent: :destroy
  accepts_nested_attributes_for :attachments
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :options ],
    associated_against: {
      course: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }
  validates :number_players, presence: true

    def users
    users = guests.map do |guest|
      User.find(guest.user_id).first_name
    end
    return users
  end
end
