filename = '03-input.txt'
zeroes = Hash.new(0)
ones = Hash.new(0)
last_bit = 0
IO.readlines(filename, chomp: true).each do |bitstr|
  bitstr.each_char.with_index(0) do |char, i|
    zeroes[i] += 1 if char == '0'
    ones[i] += 1 if char == '1'
    last_bit = i if i > last_bit
  end
end
gamma = 0
epsilon = 0
(0..last_bit).each do |i|
  gamma *= 2
  epsilon *= 2
  if ones[i] >= zeroes[i]
    gamma += 1
  else
    epsilon += 1
  end
end
            
puts "gamma = #{gamma}, epsilon = #{epsilon}, multiplied = #{gamma * epsilon}"

