class AddAttachmentparceStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :attachments, :finish_processing, :boolean, default: false
  end
end
