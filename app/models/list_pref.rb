class ListPref < ApplicationRecord
  has_many :user_preferences
  has_many :users, through: :user_preferences
end
