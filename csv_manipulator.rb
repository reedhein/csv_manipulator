# require 'spreadsheet'
require 'pry'
require 'pry-byebug'
require 'csv'

# s = SimpleSpreadsheet::Workbook.read('./Westgate Files  5-6- 2016  DAN COMBINED FILES.xlsx')
input_file = 'Lead Phone Cleanup_5.13.16.csv'
exit_file = 'funtimes.csv'
input_file_csv = CSV.open([Dir.pwd, input_file].join('/'), headers: true , encoding: 'ISO-8859-1')
# w = s.worksheet 0

def strip_non_digits(row_array, index)
  row_array[index].gsub(/\D/,'') if row_array[index] =~ /\D/
end

def remove_country_code(row_array, index)
  if !row_array[index].nil?
    plus_one_removed = row_array[index].gsub(/^\s*\+1/ , '')
    plus_one_removed.gsub!(/^\s*1-/  , '')
  end
end

def strip_ext(row_array, index)
  unless row_array[index].nil?
    result = row_array[index].split(/ext/i)
    result[0]
  end
end

CSV.open(exit_file, 'w') do |csv|
  input_file_csv.each.with_index do |line, i|
    begin
      line[4] = remove_country_code(line, 4)
      line[4] = strip_ext(line, 4)
      line[4] = strip_non_digits(line, 4)
      line[5] = remove_country_code(line, 5)
      line[5] = strip_ext(line, 5)
      line[5] = strip_non_digits(line,5)
      puts line[4]
      csv << line
    rescue => e
      puts e
      binding.pry
    end
  end
end


