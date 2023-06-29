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
winner_name = game.play(player_one, player_two)
puts "Hurray, #{winner_name} won!!!"
