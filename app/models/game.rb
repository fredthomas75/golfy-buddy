class Game < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :wishgames, dependent: :destroy
  has_many :wishlists, through: :wishgames
  accepts_nested_attributes_for :attachments
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :options, :date],
    associated_against: {
      course: [ :name, :address ]
    },
    using: {
      tsearch: { prefix: true }
    }
  validates :number_players, presence: true
  scope :upcoming, -> { where("time>= ?", [Date.today]).order('date ASC, created_at ASC') }
  scope :past, -> { where("time < ?", [Date.today]).order('date DESC, created_at DESC') }
  scope :public_games, -> { where(privacy: 'public') }
  scope :play_more, -> { where(user: current_user) }
  self.per_page = 12

    def users
    users = guests.map do |guest|
      User.find(guest.user_id).first_name
    end
    return users
  end
end
