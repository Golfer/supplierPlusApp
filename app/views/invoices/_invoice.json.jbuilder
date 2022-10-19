json.extract! invoice, :id, :user, :amount, :due_date, :sell_price, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
