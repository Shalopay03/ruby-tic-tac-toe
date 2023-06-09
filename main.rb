class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Game
  def initialize
    @field = [
      %w[1 2 3],
      %w[4 5 6],
      %w[9 8 7]
    ]
  end
end

def initialize_player
  puts 'Enter player name: '
  name = gets.chop
  puts 'Enter player symbol: '
  symbol = gets.chop
  Player.new(name, symbol)
end

puts 'First player initialization:'
player_one = initialize_player

puts player_one.name
puts player_one.symbol