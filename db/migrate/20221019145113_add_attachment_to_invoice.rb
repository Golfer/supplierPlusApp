class AddAttachmentToInvoice < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoices, :attachment, null: false, foreign_key: true
  end
end
