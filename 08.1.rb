# Advent of Code day 8: Seven Segment Search
# https://adventofcode.com/2021/day/7
oneFourSevenEight = 0
filename = '08-input.txt'
File.open(filename) do |infile|
  while line = infile.gets
    signals, output = line.chomp.split(' | ')
    output.split(' ').each do |output|
      case output.length
      when 2, 4, 3, 7 then oneFourSevenEight += 1
      end
    end
  end
end

puts "OneFourSevenEight : #{oneFourSevenEight}"
