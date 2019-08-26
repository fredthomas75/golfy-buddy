class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :type
      t.integer :number_holes
      t.integer :difficulty
      t.string :address
      t.string :phone
      t.string :website
      t.text :about_course

      t.timestamps
    end
  end
end
