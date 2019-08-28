class Game < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
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
end
