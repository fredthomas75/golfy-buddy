class ListPref < ApplicationRecord
  has_many :user_preferences
  has_many :user_personalities
end
