FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{Faker::Internet.email}-#{n}" }
    password { Faker::Internet.password }

    trait :admin do
      admin { true }
    end
  end
end
