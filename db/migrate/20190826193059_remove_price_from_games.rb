class RemovePriceFromGames < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :price, :float
  end
end
