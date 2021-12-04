filename = '02-input.txt'
horiz = 0
depth = 0
IO.readlines(filename, chomp: true).each do |command|
  direction, distance = command.split(' ')
  distance = distance.to_i
  case direction
  when 'forward' then horiz += distance
  when 'down' then depth += distance
  when 'up' then depth -= distance
  else
    puts "Unknown direction in command: #{command}"
  end
end

puts "horizontal distance #{horiz}, depth #{depth}, hxd=#{horiz * depth}"
