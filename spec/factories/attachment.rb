FactoryBot.define do
  factory :attachment do
    association :user
    description { 'Description Test' }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/csv_example.csv')) }
  end
end
