# Advent of Code day 11: Dumbo Octopus
# https://adventofcode.com/2021/day/11
FILENAME = '11-input.txt'

class Cavern
  attr_accessor :energies
  attr_accessor :total_flashes
  def initialize(lines)
    @energies = lines.map { |line| line.chars.map(&:to_i) }
    @max_row = @energies.length - 1
    @max_col = @energies[0].length - 1
    @total_flashes = 0
    puts "#{FILENAME}: row = 0..#{@max_row}, col = 0..#{@max_col}"
  end

  def energy(row, col)
    return nil if row < 0 || row > @max_row || col < 0 || col > @max_col
    energies[row][col]
  end

  def increment_all
    (0..@max_row).each do |row|
      (0..@max_col).each do |col|
        @energies[row][col] += 1
      end
    end
  end

  def flash_gt_9
    this_step_flashes = 0
    increased = true
    while increased
      start_flashes = @total_flashes
      (0..@max_row).each do |row|
        (0..@max_col).each do |col|
          if @energies[row][col] > 9
            @total_flashes += 1
            this_step_flashes += 1
            @energies[row][col] = 0
            increment_neighbors(row, col)
          end
        end
      end
      increased = @total_flashes > start_flashes
    end
    this_step_flashes == (@max_col + 1) * (@max_row + 1)
  end

  def increment_neighbors(center_row, center_col)
    (center_row-1..center_row+1).each do |row|
      (center_col-1..center_col+1).each do |col|
        if row >=0 && row <= @max_row && col >= 0 && col <= @max_col && @energies[row][col] > 0
          @energies[row][col] += 1
        end
      end
    end
  end
  
  def next_step()
    increment_all
    flash_gt_9
  end

  def to_s
    @energies.map{|row| row.map(&:to_s).join('')}.join("\n")
  end
end

octopi = Cavern.new(IO.readlines(FILENAME, chomp: true))
puts "Initial state"
puts octopi.to_s
(1..1000).each do |step|
  if octopi.next_step
    puts "Step #{step}"
    puts octopi.to_s
    # puts "flashes: #{octopi.total_flashes}"
    break
  end
end


