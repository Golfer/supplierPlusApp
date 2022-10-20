FactoryBot.define do
  factory :attachment do
    association :user
    description { 'Description Test' }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/csv_example.csv')) }

    trait :file_correct_5000 do
      file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/correct_5000.csv')) }
    end

    trait :file_incorrect_5000 do
      file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/incorrect_5000.csv')) }
    end
  end
end
