class Course < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
