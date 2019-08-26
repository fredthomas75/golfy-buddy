class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.string :options
      t.integer :number_players
      t.integer :number_guests
      t.date :date
      t.time :time
      t.float :price
      t.boolean :booked
      t.boolean :tournament
      t.text :about_game
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
