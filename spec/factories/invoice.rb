FactoryBot.define do
  factory :invoice do
    invoice_code { SecureRandom.uuid }
    amount { Faker::Number.decimal }
    due_date { Faker::Date.in_date_period(month: 3) }
  end
end
