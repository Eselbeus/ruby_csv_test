#!/usr/bin/env ruby

require 'csv'
require 'date'

file = CSV.read("./Seann_Sheet1.csv")

File.open("test_file.txt", "w")

def yesterdays_date
  date = Date.today.prev_day
  year = date.to_s.slice(2, 2)
  month = date.to_s.slice(5, 2)
  day = date.to_s.slice(8, 2)

  year + month + day
end

def converter (file)
  sales_count = 0

  final_text = []

  file.each_with_index do |line, i|
    if i == 0
      final_text.push("92" + yesterdays_date)
    else
      transaction_counter = 1

      units_per_transaction = line[6]
      if units_per_transaction.to_i > 5
        units_per_transaction = 5
      end

      while transaction_counter <= units_per_transaction.to_i
        sales_count += 1
        fixed_data = "D3|12345678|"
        zipcode = line[1]
        fixed_data2 = "|S|00"
        fixed_data3 = "||1000|A|P"

        if zipcode == nil
          zipcode = ""
        end

        final_text.push(fixed_data + zipcode + fixed_data2 + transaction_counter.to_s + fixed_data3)

        transaction_counter += 1
      end

    end
  end

  sales_count = sales_count.to_s
  final_text.push("94|" + sales_count + "|" + sales_count)

  final_text = final_text.join("\n")
  File.open("test_file.txt", "a" ) {|f| f.write(final_text)}

  return final_text
end

puts converter(file)
