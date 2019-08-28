class AddPrivacyToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :privacy, :string
  end
end
