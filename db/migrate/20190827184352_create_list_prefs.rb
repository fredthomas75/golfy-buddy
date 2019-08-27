class CreateListPrefs < ActiveRecord::Migration[5.2]
  def change
    create_table :list_prefs do |t|
      t.string :name
    end
  end
end
