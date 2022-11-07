class AddDescriptionToInvoice < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :description, :text
  end
end
