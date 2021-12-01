require 'csv'

filename = '01-input.txt'
puts "Reading #{filename}"
all = CSV.read(filename, converters: :numeric).flatten
greater = 0
sum = all[0] + all[1] + all[2]
(0..all.length-4).each do |i|
  prev = sum
  sum = sum - all[i] + all[i+3]
  greater += 1 if sum > prev
end
puts "#{greater} three-measurement sliding windows greater than previous"
