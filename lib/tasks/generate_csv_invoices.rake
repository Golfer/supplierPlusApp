namespace :generate_csv_invoices do
  desc "Correct; Example generate_csv_invoices:correct\['3000,correct_data.csv'\]"
  task :correct, [:rows, :filename] => [:environment] do |_t, args|
    puts 'Start generate CSV.'.yellow
    CsvGenerator::Correct.new(**args).processed
    puts 'Done.'.green
  end

  desc "InCorrect; Example generate_csv_invoices:correct\['3000,incorrect_data.csv'\]"
  task :incorrect, [:rows, :filename] => [:environment] do |_t, args|
    puts 'Start generate CSV.'.yellow
    CsvGenerator::Incorrect.new(**args).processed
    puts 'Done.'.green
  end
end
