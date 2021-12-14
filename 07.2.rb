# Advent of Code day 7: The Treachery of Whales
# https://adventofcode.com/2021/day/7
require 'csv'
filename = '07-input.txt'
start_positions = CSV.read(filename, converters: :numeric)[0]

def total_cost(start_positions, end_position)
  start_positions.inject(0) do |total, start|
    if start == end_position
      total
    else
      total + (1..((start - end_position).abs)).inject(:+)
    end
  end
end

min_position, max_position = start_positions.minmax
costs = (min_position..max_position).map { |end_position| total_cost(start_positions, end_position) }
puts "positions : #{min_position}..#{max_position}"
#puts "costs : #{costs}"
puts "Value and position of minimum cost : #{costs.each_with_index.min}"
