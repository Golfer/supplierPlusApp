module CsvGenerator
  class Correct < CsvGenerator::Base
    def initialize(**args)
      super
      @filename = args[:filename] || "correct_#{rows}.csv"
    end
  end
end
