class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :user, foreign_key: true
      t.string :invoice_code
      t.datetime :due_date
      t.decimal :amount
      t.decimal :sell_price

      t.timestamps
    end
  end
end
