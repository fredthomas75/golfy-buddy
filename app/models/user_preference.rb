class UserPreference < ApplicationRecord
  belongs_to :user
  belongs_to :list_pref
end
