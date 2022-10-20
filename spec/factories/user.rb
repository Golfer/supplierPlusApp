FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{Faker::Internet.email}-#{n}" }
    password { Faker::Internet.password }

    # attachments { FactoryBot.create(:attachment) }
  end
end
