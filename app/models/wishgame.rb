class Wishgame < ApplicationRecord
  belongs_to :game
  belongs_to :wishlist
end
