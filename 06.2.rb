# Advent of Code day 6
# https://adventofcode.com/2021/day/6
require 'csv'
filename = '06-input.txt'
days = 128 #256
input_fish = CSV.read(filename, converters: :numeric)[0]

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

unique_fish = (0..9)
puts "Unique Fish : #{unique_fish}"

fish_after_128 = Hash.new(0)
unique_fish.each do |fish|
  uniq_fish_array = [fish]
  #each_day_length = []
  (1..days).each do |day|
    uniq_fish_array = next_day(uniq_fish_array)
    #each_day_length << uniq_all_fish.length
  end
  fish_after_128[fish] = uniq_fish_array
  puts "#{fish}: After #{days} days, #{uniq_fish_array.length} fish."
end

total_count = 0
input_fish.each do |fish|
  fish_after_128[fish].each do |precomputed_fish|
    total_count += fish_after_128[precomputed_fish].length
  end
end
puts "Finally, After #{days * 2} days #{total_count} fish."
