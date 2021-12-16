# Advent of Code day 10: 
# https://adventofcode.com/2021/day/10
FILENAME = '10-sample.txt'
openers = '([{<'.chars
closers = ')]}>'.chars
points_for = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }
each_line_points = []
IO.readlines(FILENAME, chomp: true).each do |line|
  #puts "Scanning #{line}"
  open = []
  line.chars.each do |ch|
    open_index = openers.index(ch)
    if open_index
      open.push(open_index)
      #puts "Opened: #{ch}", open.map{|i| openers[i]}
    else
      expected = closers[open.last]
      if ch != expected
        #puts "#{line} - Expected #{expected} but found #{ch} instead: #{open.map{|i| openers[i]}}"
        open = []
        break # next line
      else
        open.pop
        #puts "Closed: #{ch}", open.map{|i| openers[i]}
      end
    end
  end
  current_points = 0
  while open.length > 0
    ch = open.pop
    current_points = current_points * 5 + points_for[closers[ch]]
  end
  each_line_points << current_points if current_points > 0
end
puts "#{FILENAME}: points = #{each_line_points}"
puts "Middle score = #{each_line_points.sort[each_line_points.length/2]}"
