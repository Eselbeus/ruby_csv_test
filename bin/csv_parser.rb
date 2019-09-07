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
      sales_count += 1
      zipcode = line[1]
      if zipcode == nil
        zipcode = ""
      end
      fixed_data = "D3|12345678|"
      fixed_data2 = "|S|"
      fixed_data3 = "||1000|A|P"
      final_text.push(fixed_data + zipcode + fixed_data2 + fixed_data3)
    end
  end
  sales_count -= 1
  sales_count = sales_count.to_s
  final_text.push("94|" + sales_count + "|" + sales_count)
  File.open("test_file.txt", "a" ) {|f| f.write(final_text)}
  # final_text += lines

  return final_text
end

puts converter(file)
