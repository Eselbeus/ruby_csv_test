#!/usr/bin/env ruby

require 'csv'
require 'date'

file = CSV.read("./Seann_Sheet1.csv")

File.open("converted_file.txt", "w")

def yesterdays_date
  date = Date.today.prev_day
  year = date.to_s.slice(2, 2)
  month = date.to_s.slice(5, 2)
  day = date.to_s.slice(8, 2)

  year + month + day
end

def data_line (zipcode, sale_counter)
  if zipcode == nil
    zipcode = ""
  end

  "D3|12345678|#{zipcode}|S|00#{sale_counter.to_s}||1000|A|P"
end

def converter (file)
  final_text = []
  total_sales = 0 #total sales gets incremented inside while loop so each of the sales within a transaction count

  file.each_with_index do |line, i|
    if i == 0
      final_text.push("92" + yesterdays_date) #builds first line
    else
      sales_counter = 1 #initializes loop that gives each sale a number 001-005
      sales_per_transaction = line[6] #this is the number of sales per transaction from the csv

      if sales_per_transaction.to_i > 5
        sales_per_transaction = 5
      end

      while sales_counter <= sales_per_transaction.to_i
        total_sales += 1
        zipcode = line[1]
        final_text.push(data_line(zipcode, sales_counter))

        sales_counter += 1
      end
    end
  end

  total_sales = total_sales.to_s
  final_text.push("94|" + total_sales + "|" + total_sales)

  final_text = final_text.join("\n") #converts from array into string format with each element on a new line
  File.open("converted_file.txt", "a" ) {|f| f.write(final_text)} #writes the entire completed string to a text file

  return final_text
end

converter(file)
