module CsvGenerator
  class Incorrect < CsvGenerator::Base
    def initialize(**args)
      super
      @filename = args[:filename] || "incorrect_#{rows}.csv"
    end

    def random_id
      [incorrect_id, correct_id].shuffle!.first
    end

    def random_amount
      [correct_amount, incorrect_amount].shuffle!.first
    end

    def random_due_date
      rand_format = ['%d%m/%Y', '%d%m %Y', '%d--%m--%Y', '%Y-%m-%d', '%d %m   %Y']

      date = DateTime.now
      date.next_day(rand(1..65)).strftime(rand_format.shuffle!.first)
    end

    def correct_id
      SecureRandom.uuid
    end

    def incorrect_id
      [('a'..'z'), (0..9)].map(&:to_a).flatten.sample(8).join
    end

    def correct_amount
      rand(50..85_000)
    end

    def incorrect_amount
      [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten.sample(2).join
    end
  end
end
