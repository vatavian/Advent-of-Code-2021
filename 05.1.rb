# Advent of Code day 5
# https://adventofcode.com/2021/day/5

filename = '05-input.txt'
@grid = Hash.new(0)

def read_line(infile)
  p1, p2 = infile.gets.chomp.split(' -> ')
  x1, y1 = p1.split(',').map(&:to_i)
  x2, y2 = p2.split(',').map(&:to_i)
  if x1 == x2
    min, max = [y1, y2].minmax
    (min..max).each {|y| @grid[[x1, y]] += 1}
  elsif y1 == y2
    min, max = [x1, x2].minmax
    (min..max).each {|x| @grid[[x, y1]] += 1}    
  end
end

File.open(filename) do |infile|
  while !infile.eof
    read_line(infile)
  end
end

puts "Points covered by more than one line: #{@grid.values.count {|n| n > 1}}"

