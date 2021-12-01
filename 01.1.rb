all = []
File.open('01-input.txt') do |infile|
  while line = infile.gets
    all.append line.chomp.to_i
  end
end
greater = 0
prev = nil
all.each do |depth|
  greater += 1 if prev != nil && depth > prev
  prev = depth
end
puts greater
