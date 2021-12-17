# Advent of Code day 14: Extended Polymerization
# https://adventofcode.com/2021/day/14
FILENAME = '14-input.txt'

polymer_template = nil
insertion_rules = Hash.new
IO.readlines(FILENAME, chomp: true).each do |line|
  if polymer_template == nil
    polymer_template = line.chars
  elsif line.include?(' -> ')
    pair, insert = line.split(' -> ')
    insertion_rules[pair] = insert
  end
end
puts "#{FILENAME}: read #{insertion_rules.length} rules"

10.times do
  next_polymer = [polymer_template[0]]
  prev_char = polymer_template[0]
  polymer_template[1..].each do |next_char|
    rule = insertion_rules[prev_char + next_char]
    next_polymer.append rule if rule
    next_polymer.append next_char
    prev_char = next_char
  end
  polymer_template = next_polymer
end
# puts polymer_template.join()
counts = polymer_template.group_by { |v| v }.map { |k, v| [k, v.size] }.to_h
sorted_counts = counts.sort_by{|k, v| v}
puts sorted_counts[sorted_counts.length-1][1] - sorted_counts[0][1]
