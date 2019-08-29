class AddShareOfPriceToGuests < ActiveRecord::Migration[5.2]
  def change
        add_column :guests, :share_of_price, :integer
  end
end
