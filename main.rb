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

  def play
    show_field
  end

  def show_field
    puts @field[0][0] + ' | ' + @field[0][1] + ' | ' + @field[0][2]
    puts '---------'
    puts @field[1][0] + ' | ' + @field[1][1] + ' | ' + @field[1][2]
    puts '---------'
    puts @field[2][0] + ' | ' + @field[2][1] + ' | ' + @field[2][2]
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
puts 'Second player initialization:'
player_one = initialize_player

game = Game.new
game.play
