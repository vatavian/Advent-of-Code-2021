# Advent of Code day 9: Smoke Basin Lava Tubes
# https://adventofcode.com/2021/day/9
FILENAME = '09-input.txt'

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

  def basin_size(row, col, filled = Hash.new(false))
    return 0 if row < 0 || row > @max_row || col < 0 || col > @max_col || filled[[row, col]] || height(row, col) == 9
    filled[[row, col]] = true
    1 +
      basin_size(row + 1, col, filled) +
      basin_size(row - 1, col, filled) +
      basin_size(row, col - 1, filled) +
      basin_size(row, col + 1, filled)
  end
  
  def basins()
    found_basins = []
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
        # row, col is a low point
        found_basins.append(basin_size(row, col))
      end
    end
    found_basins
  end

end

heightmap = HeightMap.new(IO.readlines(FILENAME, chomp: true))
basins = heightmap.basins
puts "All: #{basins}"
largest_3 = basins.sort[-3..-1]
puts "Three largest: #{largest_3}"
puts "Multiplied: #{largest_3[0] * largest_3[1] * largest_3[2]}"
