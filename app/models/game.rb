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

  filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
            :available_filters => %w[
            sorted_by
            search_query
            search_location
            with_course_id
            with_date
          ]

  scope :search_query, ->(query) {
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      ('%'+e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          "LOWER(games.name) LIKE ?",
          "LOWER(games.about_game) LIKE ?",
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

    scope :search_location, ->(query) {
    return nil if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/,/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      ('%'+e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          "LOWER(games.location) ILIKE ?",
          "LOWER(games.country) ILIKE ?",
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' OR '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /asc$/) ? 'asc' : 'desc'
    games = Game.arel_table
    case sort_option.to_s
    when /^created_at_/
      # order("games.created_at #{direction}")
      order(games[:created_at].send(direction))
    when /^name_/
      # order("LOWER(games.name) #{direction}")
      order(games[:name].lower.send(direction))
    when /^number_players_/
      order(games[:number_players].send(direction))
    when /^time_/
      order(games[:time].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_course_id, ->(course_ids) {
    where(:course_id => [*course_ids])
  }

  scope :with_date, -> (date){
    where("time >= ? AND time < ?", date.to_date, date.to_date + 1)
  }

  # delegate :name, :to => :course, :prefix => true

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

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Name (z-a)', 'name_desc'],
      ['Date (newest first)', 'time_desc'],
      ['Date (oldest first)', 'time_asc'],
      ['Number of players (2-4)', 'number_players_asc'],
      ['Number of players (4-2)', 'number_players_desc'],
    ]
  end

  def self.options_for_select
    games = Game.arel_table
    order(games[:course_id]).distinct.pluck(:course_id)
  end

end
