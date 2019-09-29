class AddLocationToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :location, :string
    add_column :games, :country, :string
  end
end
