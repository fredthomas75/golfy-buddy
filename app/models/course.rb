class Course < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :course_attachments, dependent: :destroy
  accepts_nested_attributes_for :course_attachments
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :attachments, as: :attachable
end
