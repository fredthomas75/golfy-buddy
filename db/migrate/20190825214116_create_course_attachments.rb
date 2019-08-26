class CreateCourseAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :course_attachments do |t|
      t.string :photo
      t.references :course, foreign_key: true
    end
  end
end
