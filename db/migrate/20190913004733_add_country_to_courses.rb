class AddCountryToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :country, :string
  end
end
