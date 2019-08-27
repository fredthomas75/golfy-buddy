class ListPref < ApplicationRecord
  has_many :user_preferences, dependent: :destroy
  has_many :user_personalities, dependent: :destroy
end
