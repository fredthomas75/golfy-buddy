class Buddy < ApplicationRecord
  belongs_to :one_user, :class_name => 'User'
  belongs_to :two_user, :class_name => 'User'
  belongs_to :last_action_user, :class_name => 'User'
end
