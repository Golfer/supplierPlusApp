FactoryBot.define do
  factory :attachment do
    association :user
    description { 'Description Test' }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/csv_example.csv')) }

    trait :file_correct_50 do
      file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/correct_50.csv')) }
    end

    trait :file_incorrect_50 do
      file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/incorrect_50.csv')) }
    end
  end
end
