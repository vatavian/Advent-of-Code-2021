# Bingo! Advent of Code day 4
# https://adventofcode.com/2021/day/4

filename = '04-input.txt'
@card_range = (0..4)
@cards = []
@draws = []
@drew = []
def read_card(infile)
  card = []
  while card.length < 5
    row = infile.gets.chomp.split(' ').map(&:to_i)
    card.append row if row.length == 5
  end
  @cards.append card
end

def mark_drawn(card, draw)
  @card_range.each do |row_index|
    card[row_index].map! { |square| square == draw ? 0 : square }
  end
end

def is_winner(card)
  # check for a winning row
  card.each do |row|
    return true if row.sum == 0
  end
  # check for a winning column
  @card_range.each do |c|
    return true if card[0][c] == 0 &&
                   card[1][c] == 0 &&
                   card[2][c] == 0 &&
                   card[3][c] == 0 &&
                   card[4][c] == 0
  end
  false
end

File.open(filename) do |infile|
  @draws = infile.gets.chomp.split(',').map(&:to_i)
  while !infile.eof
    read_card(infile)
  end
end

last_winner = nil
@draws.each do |draw|
  @drew.append draw
  @cards.each do |card|
    mark_drawn(card, draw)
  end
  @cards.delete_if {|card| is_winner(card) }
  last_winner = @cards[0] if @cards.length == 1
  if @cards.length == 0
    puts "Drew: #{@drew}"
    puts "Last Winner: \n#{last_winner}"
    puts "Score: #{last_winner.flatten.sum * draw}"
    exit
  end
end
