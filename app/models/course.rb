class Course < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
              :available_filters => %w[
              sorted_by
              search_query
              with_country
            ]

  self.per_page = 12

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
    num_or_conditions = 1
    where(
      terms.map {
        or_clauses = [
          "LOWER(courses.name) LIKE ?",
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /asc$/) ? 'asc' : 'desc'
    courses = Course.arel_table
    case sort_option.to_s
    when /^created_at_/
      # order("courses.created_at #{direction}")
      order(courses[:created_at].send(direction))
    when /^name_/
      # order("LOWER(courses.name) #{direction}")
      order(courses[:name].lower.send(direction))
    when /^difficulty_/
      order(courses[:difficulty].send(direction))
    when /^style_/
      order(courses[:style].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_country, ->(country) {
    where(:country => [*country])
  }

  delegate :name, :to => :country, :prefix => true

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Name (z-a)', 'name_desc'],
      ['Difficulty (1-3)', 'difficulty_asc'],
      ['Difficulty (3-1)', 'difficulty_desc'],
      ['Style (a-z)', 'style_asc'],
    ]
  end

  def self.options_for_select
    courses = Course.arel_table
    order(courses[:country].lower).pluck(:country).uniq
  end
end
