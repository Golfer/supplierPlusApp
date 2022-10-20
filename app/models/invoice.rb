class Invoice < ApplicationRecord
  DISCOUNT_DATE = 30
  belongs_to :user
  belongs_to :attachment
  validates :invoice_code, presence: true
  validates :amount, numericality: true

  # due_date format must be YYYY-MM-DD
  validates :due_date,
            presence: true,
            format: { with: /\d{4}-\d{2}-\d{2}/, message: I18n.t('.validate.bad_format', day_format: 'yyyy-mm-dd') }

  after_validation :calculate_sell_price

  def calculate_sell_price
    self.sell_price = amount.to_i - (amount.to_i * discount_persent)
  end

  def discount_persent
    return 0.05 if date_to_invoices.to_i >= DISCOUNT_DATE
    return 0.03 if date_to_invoices.to_i <= DISCOUNT_DATE

    0
  end

  def date_to_invoices
    return if due_date.nil?

    (due_date.to_date - Time.zone.today).to_i
  end
end
