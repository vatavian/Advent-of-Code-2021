filename = '03-input.txt'

def most_common_value(bit, list)
  zeroes = 0
  ones = 0
  list.each do |bitstr|
    case bitstr[bit]
    when '0' then zeroes += 1
    when '1' then ones += 1
    end
  end
  ones >= zeroes ? '1' : '0'
end

def oxygen_rating(list, bit = 0)
  return list[0].to_i(2) if list.length == 1
  seek_value = most_common_value(bit, list)
  oxygen_rating(list.select { |v| v[bit] == seek_value }, bit + 1)
end

def co2_rating(list, bit = 0)
  return list[0].to_i(2) if list.length == 1
  seek_value = least_common_value(bit, list)
  co2_rating(list.select { |v| v[bit] == seek_value }, bit + 1)
end

def least_common_value(bit, list)
  zeroes = 0
  ones = 0
  list.each do |bitstr|
    case bitstr[bit]
    when '0' then zeroes += 1
    when '1' then ones += 1
    end
  end
  zeroes <= ones ? '0' : '1'
end

last_bit = 0
list = IO.readlines(filename, chomp: true)
last_bit = list[0].length-1
oxy = oxygen_rating(list)
co2 = co2_rating(list)
puts "oxygen_rating: #{oxy}"
puts "co2: #{co2}"
puts "multiplied = #{oxy * co2}"

