class CreateBuddies < ActiveRecord::Migration[5.2]
  def change
    create_table :buddies do |t|
      t.string :status
      t.references :one_user
      t.references :two_user
      t.references :last_action_user
      t.timestamps
    end
  end
end
