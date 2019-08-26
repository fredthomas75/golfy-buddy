class AddPrivacyToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :privacy, :boolean
    add_column :games, :game_price, :float
  end
end
