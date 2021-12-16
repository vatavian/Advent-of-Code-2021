# Advent of Code day 9: Smoke Basin Lava Tubes
# https://adventofcode.com/2021/day/9
FILENAME = '09-input.txt'
#1636 too high

class HeightMap
  attr_accessor :heights
  def initialize(lines)
    @heights = lines.map { |line| line.chars.map(&:to_i) }
    @max_row = @heights.length - 1
    @max_col = @heights[0].length - 1
    puts "#{FILENAME}: row = 0..#{@max_row}, col = 0..#{@max_col}"
  end

  def height(row, col)
    return nil if row < 0 || row > @max_row || col < 0 || col > @max_col
    heights[row][col]
  end

  def low_total_risk()
    total = 0
    (0..@max_row).each do |row|
      (0..@max_col).each do |col|
        this_height = height(row, col)
        neighbor_height = height(row - 1, col)
        next if neighbor_height && neighbor_height <= this_height 
        neighbor_height = height(row + 1, col)
        next if neighbor_height && neighbor_height <= this_height 
        neighbor_height = height(row, col - 1)
        next if neighbor_height && neighbor_height <= this_height 
        neighbor_height = height(row, col + 1)
        next if neighbor_height && neighbor_height <= this_height
        total += this_height + 1
      end
    end
    total
  end
end

heightmap = HeightMap.new(IO.readlines(FILENAME, chomp: true))

puts "Total low point risk : #{heightmap.low_total_risk}"
