# Advent of Code day 5
# https://adventofcode.com/2021/day/5
# 20645 too low
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
  else
    x = x1; y = y1
    dx = (x2 > x1) ? 1 : -1
    dy = (y2 > y1) ? 1 : -1
    loop do
      @grid[[x, y]] += 1
      break if x == x2
      x += dx; y += dy
    end
  end
end

File.open(filename) do |infile|
  while !infile.eof
    read_line(infile)
  end
end

puts "Points covered by more than one line: #{@grid.values.count {|n| n > 1}}"

(0..9).each do |y|
  line = ''
  (0..9).each do |x|
    line += @grid[[x, y]].to_s
  end
  puts line
end
