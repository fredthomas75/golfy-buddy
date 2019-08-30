class CreateUserPersonalities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_personalities do |t|
      t.references :user, foreign_key: true
      t.references :list_pref, foreign_key: true

      t.timestamps
    end
  end
end
