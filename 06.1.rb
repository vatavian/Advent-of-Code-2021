# Advent of Code day 6
# https://adventofcode.com/2021/day/6
require 'csv'
filename = '06-input.txt'
all_fish = CSV.read(filename, converters: :numeric)[0]

def next_day(fishes)
  new_fishes = []
  fishes.each do |fish|
    if fish > 0
      new_fishes << fish - 1
    else
      new_fishes << 6 << 8
    end
  end
  new_fishes
end

puts "Initial State : #{all_fish.join(',')}"

days = 80
(1..days).each do |day|
  all_fish = next_day(all_fish)
end

puts "After #{days} days #{all_fish.length} fish." #: #{all_fish.join(',')}"


