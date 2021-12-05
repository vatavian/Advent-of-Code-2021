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

@draws.each do |draw|
  @drew.append draw
  @cards.each do |card|
    mark_drawn(card, draw)
    if is_winner(card)
      puts "Drew: #{@drew}"
      puts "Winner: \n#{card}"
      puts "Score: #{card.flatten.sum * draw}"
      exit
    end
  end
end
