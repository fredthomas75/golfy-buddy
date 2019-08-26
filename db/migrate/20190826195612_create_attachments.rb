class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.string :photo
      t.references :attachable, polymorphic: true
      t.timestamps
    end
  end
end
