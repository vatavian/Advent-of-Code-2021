# Advent of Code day 10: 
# https://adventofcode.com/2021/day/10
FILENAME = '10-input.txt'
openers = '([{<'.chars
closers = ')]}>'.chars
points_for = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25137 }
current_points = 0
IO.readlines(FILENAME, chomp: true).each do |line|
puts "Scanning #{line}"
  open = []
  line.chars.each do |ch|
    open_index = openers.index(ch)
    if open_index
      open.push(open_index)
      #puts "Opened: #{ch}", open.map{|i| openers[i]}
    else
      expected = closers[open.last]
      if ch != expected
        current_points += points_for[ch]
        puts "#{line} - Expected #{expected} but found #{ch} instead: #{open.map{|i| openers[i]}}"
        break # next line
      else
        open.pop
        #puts "Closed: #{ch}", open.map{|i| openers[i]}
      end
    end
  end
end
puts "#{FILENAME}: points = #{current_points}"
