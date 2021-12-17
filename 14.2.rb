# Advent of Code day 14: Extended Polymerization
# https://adventofcode.com/2021/day/14
FILENAME = '14-input.txt'
CACHE_STEPS = 20
TOTAL_STEPS = 40

@insertion_rules = Hash.new
@cache_for_pairs = Hash.new
@totals = Hash.new(0)

def count_between(c1, c2, times)
  pair = c1 + c2
  if times > 0 && rule = @insertion_rules[pair]
    if times == CACHE_STEPS
      if precomputed = @cache_for_pairs[pair]
        precomputed.each {|k, v| @totals[k] += v }
      else
        before = @totals.dup
        count_between(c1, rule, times - 1)
        count_between(rule, c2, times - 1)
        precomputed = Hash.new(0)
        @totals.each {|k, v| precomputed[k] = v - before[k]}
        @cache_for_pairs[pair] = precomputed
        puts "Precomputed #{pair}: #{precomputed}"
      end
    else
      count_between(c1, rule, times - 1)
      count_between(rule, c2, times - 1)
    end
  else
    @totals[c1] += 1
    #puts "Total #{c1} = #{@totals[c1]}" if @totals[c1].to_s[1..].gsub('0', '') == ''
  end
end

polymer_template = nil
IO.readlines(FILENAME, chomp: true).each do |line|
  if polymer_template == nil
    polymer_template = line.chars
  elsif line.include?(' -> ')
    pair, insert = line.split(' -> ')
    @insertion_rules[pair] = insert
  end
end
puts "#{FILENAME}: read #{@insertion_rules.length} rules"

prev_char = polymer_template[0]
polymer_template[1..].each do |next_char|
  puts "Counting between #{prev_char} and #{next_char}"
  count_between(prev_char, next_char, TOTAL_STEPS)
  prev_char = next_char
end
@totals[polymer_template[-1]] += 1
sorted_counts = @totals.sort_by{|k, v| v}
puts "Most common: #{sorted_counts[sorted_counts.length-1]}"
puts "Least common: #{sorted_counts[0]}"
puts "Most - least = #{sorted_counts[sorted_counts.length-1][1] - sorted_counts[0][1]}"
