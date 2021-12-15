# Advent of Code day 8: Seven Segment Search
# https://adventofcode.com/2021/day/7
filename = '08-input.txt'

@real_segments = []
@real_segments[0] = 'abcefg'
@real_segments[1] = 'cf'
@real_segments[2] = 'acdeg'
@real_segments[3] = 'acdfg'
@real_segments[4] = 'bcdf'
@real_segments[5] = 'abdfg'
@real_segments[6] = 'abdefg'
@real_segments[7] = 'acf'
@real_segments[8] = 'abcdefg'
@real_segments[9] = 'abcdfg'

# a = letter in 7[3] not in 1[2]
# bd = letters in 4[4] not in 1[2]

# b = letter in 4[4], not 1[2], in only one of the 5-letters
# d = other letter in 4 not 1
# e = letter in only one of 5-letters that is not b
# c = letter in 2 6-letters that is not d or e
# f = letter in two 5-letters that is not c
# g = remaining letter

def find_bd(signals_by_length)
  bd_candidates = signals_by_length[4][0].delete(signals_by_length[2][0])
  candidate = bd_candidates[0]
  if signals_by_length[5].count { |signal| signal.include?(candidate) } == 1
    return [bd_candidates[0], bd_candidates[1]]
  else
    return [bd_candidates[1], bd_candidates[0]]
  end
end

def find_e(signals_by_length, b_char)
  all_5 = signals_by_length[5].join('')
  all_5.chars.uniq.reject { |candidate| candidate == b_char }.each do |candidate|
    return candidate if all_5.count(candidate) == 1
  end
  nil
end

def find_c(signals_by_length, d_char, e_char)
  all = signals_by_length[6].join('')
  all.chars.uniq.reject { |ch| ch == d_char || ch == e_char}.each do |candidate|
    return candidate if all.count(candidate) == 2
  end
  puts "Cound not find c"
end

def find_f(signals_by_length, c_char)
  all = signals_by_length[5].join('')
  all.chars.uniq.reject { |ch| ch == c_char}.each do |candidate|
    return candidate if all.count(candidate) == 2
  end
  puts "Cound not find f"
end

def find_g(a,b,c,d,e,f)
  "abcdefg".delete(a+b+c+d+e+f)
end

def decode_output_digit(signals, char_map)
  key = signals.chars.map { |signal| char_map[signal] }.sort.join('')
  #puts "Real segments = #{@real_segments}"
  #puts "signals = #{signals}"
  #puts "decoded = #{key}"
  @real_segments.find_index key
end

def output_value(line)
  signals_s, outputs_s = line.chomp.split(' | ')
  signals = signals_s.split(' ')
  signals_by_length = [[],[],[],[],[],[],[],[],[],[]]
  signals.each { |signal| signals_by_length[signal.length].append(signal) }
  #  signal_possibilites = signals.map { |signal| real_segments_by_length(signal.length) }
  a_char = signals_by_length[3][0].delete(signals_by_length[2][0])
  b_char, d_char = find_bd(signals_by_length)
  e_char = find_e(signals_by_length, b_char)
  c_char = find_c(signals_by_length, d_char, e_char)
  f_char = find_f(signals_by_length, c_char)
  g_char = find_g(a_char, b_char, c_char, d_char, e_char, f_char)
  char_map = { a_char => 'a',
               b_char => 'b',
               c_char => 'c',
               d_char => 'd',
               e_char => 'e',
               f_char => 'f',
               g_char => 'g' }
  #puts char_map
  output_strings = outputs_s.split(' ')
  return_value = 0
  output_strings.each do |digit|
    decoded_digit = decode_output_digit(digit, char_map)
    #puts "Output #{digit} == #{decoded_digit}"
    return_value = return_value * 10 + decoded_digit
  end
  return_value
end

total_output = 0
File.open(filename) do |infile|
  while line = infile.gets
    total_output += output_value(line)
  end
end

puts "Total output : #{total_output}"
