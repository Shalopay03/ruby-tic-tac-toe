class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Game
  def initialize
    @field = %w[1 2 3 4 5 6 7 8 9]
  end

  # playing game method
  def play(player_one, _player_two)
    play_round(player_one)
    show_field
  end

  # outputs game field
  def show_field
    puts @field[0] + ' | ' + @field[1] + ' | ' + @field[2]
    puts '---------'
    puts @field[3] + ' | ' + @field[4] + ' | ' + @field[5]
    puts '---------'
    puts @field[6] + ' | ' + @field[7] + ' | ' + @field[8]
  end

  # gets player choice and places x or o on the field
  def play_round(player)
    choice = nil
    loop do
      puts player.name + ', choose the avaible cell between 1 and 9:'
      choice = gets.chr
      break if @field.include? choice and choice != 'x' and choice != 'o'
    end
    @field[@field.find_index(choice)] = player.symbol
  end
end

def initialize_player(symbol)
  puts 'Enter player name: '
  name = gets.chop
  Player.new(name, symbol)
end

puts 'First player initialization:'
player_one = initialize_player('x')
puts 'Second player initialization:'
player_two = initialize_player('o')

game = Game.new
game.show_field
game.play(player_one, player_two)
