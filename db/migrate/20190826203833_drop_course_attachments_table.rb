class DropCourseAttachmentsTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :course_attachments
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
