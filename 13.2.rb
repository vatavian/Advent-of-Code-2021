# Advent of Code day 13: Transparent Origami
# https://adventofcode.com/2021/day/13
FILENAME = '13-input.txt'

class Paper
  attr_accessor :dots
  attr_accessor :folds
  def initialize(input)
    @dots = Hash.new(false)
    @folds = []
    @max_x = 0
    @max_y = 0
    reading_dots = true
    input.each do |line|
      if reading_dots
        if line.include?(',')
          x, y = line.split(',').map(&:to_i)
          @max_x = x if x > @max_x
          @max_y = y if y > @max_y
          @dots[[x, y]] = true
        else
          reading_dots = false
        end
      elsif line.include?('fold along')
        fold, along, axisval = line.split(' ')
        axis, value = axisval.split('=')
        @folds.append([axis, value.to_i])
      end
    end
    puts "#{FILENAME}: x = 0..#{@max_x}, y = 0..#{@max_y}"
  end

  def fold(axis, line_value)
    new_dots = Hash.new(false)
    if axis == 'y'
      @dots.each do |key, value|
        if value
          x, y = key
          if y < line_value
            new_dots[key] = true
          else
            new_dots[[x, line_value - (y - line_value)]] = true
          end
        end
      end
      @max_y = line_value - 1
    else # axis == 'x'
      @dots.each do |key, value|
        if value
          x, y = key
          if x < line_value
            new_dots[key] = true
          else
            new_dots[[line_value - (x - line_value), y]] = true
          end
        end
      end
      @max_x = line_value - 1
    end
    @dots = new_dots
  end

  def to_s
    (0..@max_y).map do |y|
      (0..@max_x).map { |x| @dots[[x, y]] ? "#" : '.' }.join()      
    end.join("\n")
  end

end

board = Paper.new(IO.readlines(FILENAME, chomp: true))
puts "Initial state"
puts "Dots visible: #{board.dots.length}"
#puts board.to_s
#puts "Fold #{board.folds[0]}"
board.folds.each { |fold_instruction| board.fold(*fold_instruction) }
puts "After folding"
puts "Dots visible: #{board.dots.length}"
puts board.to_s
#(1..1000).each do |step|
#  if octopi.next_step
#    puts "Step #{step}"
#    puts octopi.to_s
#    # puts "flashes: #{octopi.total_flashes}"
#    break
#  end
#end


