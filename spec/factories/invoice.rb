FactoryBot.define do
  factory :invoice do
    invoice_code { SecureRandom.uuid }
    amount { Faker::Number.decimal }
    due_date { Faker::Date.forward(days: 90) }
    association :user
    association :attachment

    trait :incorrect_date do
      due_date { Faker::Date.forward(days: 23).strftime('%d---%Y') }
    end

    trait :incorrect_amount do
      amount { Faker::String.random }
    end
  end
end
