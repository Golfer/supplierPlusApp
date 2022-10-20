module InvoiceFileGenerators
  module Csv
    class Correct < InvoiceFileGenerators::Csv::Base
      def initialize(**args)
        super
        @filename = args[:filename] || "correct_#{rows}.csv"
      end
    end
  end
end
