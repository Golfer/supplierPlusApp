require 'csv'
module InvoiceFileGenerators
  module Csv
    class Base
      attr_reader :filename, :folder_path, :rows

      def initialize(**args)
        @rows = args[:rows] || 5000
        @folder_path = Rails.public_path.join('invoices', 'files')
        FileUtils.mkdir_p(@folder_path)
        @filename = args[:filename] || "data_#{rows}.csv"
      end

      def processed
        insert_line_header
        generate_rows
        Rails.logger.info "Rows: #{CSV.foreach(file_path, headers: true).count}; Path: #{file_path}"

        CSV.foreach(file_path, headers: true).count
      end

      private

      def generate_rows
        @amount_times = rows.to_i / 100

        generator(lines: rows.to_i) if @amount_times.zero?

        (1..@amount_times).collect do |_i|
          generator(lines: 100)
        end
      end

      def file_path
        Rails.public_path.join('invoices', 'files', filename)
      end

      def generator(lines: 1)
        CSV.open(file_path, 'ab') do |csv|
          lines.times do
            csv << [random_id, random_amount, random_due_date]
          end
        end
      end

      def random_id
        SecureRandom.uuid
      end

      def random_amount
        rand(50..2500)
      end

      def random_due_date
        date = DateTime.now
        date.next_day(rand(1..45)).strftime('%Y-%m-%d')
      end

      def insert_line_header
        data_csv = CSV.open(file_path, 'w+') do |csv|
          csv << attributes_headers
        end
        data_csv.close
      end

      def attributes_headers
        %w[invoice_code amount due_date]
      end
    end
  end
end
