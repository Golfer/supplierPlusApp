class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.references :user, foreign_key: true
      t.string :file
      t.string :file_processed
      t.string :description

      t.timestamps
    end
  end
end
