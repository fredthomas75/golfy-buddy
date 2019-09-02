class CreateWishgames < ActiveRecord::Migration[5.2]
  def change
    create_table :wishgames do |t|
      t.references :game, foreign_key: true
      t.references :wishlist, foreign_key: true

      t.timestamps
    end
  end
end
