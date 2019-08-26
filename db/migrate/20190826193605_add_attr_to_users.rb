class AddAttrToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :birth_date, :date
    add_column :users, :gender, :integer
    add_column :users, :language, :string
    add_column :users, :current_city, :string
    add_column :users, :handicap, :float
    add_column :users, :rating, :integer
    add_column :users, :about_me, :text
  end
end
