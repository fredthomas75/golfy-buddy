class CourseAttachment < ApplicationRecord
  belongs_to :course
  mount_uploader :photo, PhotoUploader
end
