#!/usr/bin/env ruby

require 'csv'
require 'date'

puts "hello world"

file = CSV.read("./Seann_Sheet1.csv")



# print file

# date = Date.today.prev_day
# year = date.to_s.slice(2, 2)
# month = date.to_s.slice(5, 2)
# day = date.to_s.slice(8, 2)
# yesterday = year + month + day
# line_one = "92" + yesterday

def converter (file)
  sales_count = 0

  date = Date.today.prev_day
  year = date.to_s.slice(2, 2)
  month = date.to_s.slice(5, 2)
  day = date.to_s.slice(8, 2)
  sales = sales_count
  final_text = []

  file.each_with_index do |line, i|
    if i == 0
      final_text.push("92" + year + month + day)
    else
      sales_count += 1
      zipcode = line[1]
      if zipcode == nil
        zipcode = ""
      end
      fixed_data = "D3|12345678|"
      fixed_data2 = "|S|"
      final_text.push(fixed_data + zipcode + fixed_data2)
    end
  end
  final_text.push(sales_count - 1)

  # final_text += lines

  return final_text
end

puts converter(file)
