# frozen_string_literal: true

require_relative 'player'

# class that contains game methods
class Game
  def initialize
    @field = %w[1 2 3 4 5 6 7 8 9]
  end

  # playing game method
  def play(player_one, player_two)
    rounds_played = 0
    loop do
      play_round(player_one)
      show_field
      return player_one.name if won?(player_one)

      rounds_played += 1

      return 'friendship' if rounds_played == 9

      play_round(player_two)
      show_field
      return player_two.name if won?(player_two)

      rounds_played += 1
    end
  end

  # outputs game field
  def show_field
    puts "#{@field[0]} | #{@field[1]} | #{@field[2]}"
    puts '---------'
    puts "#{@field[3]} | #{@field[4]} | #{@field[5]}"
    puts '---------'
    puts "#{@field[6]} | #{@field[7]} | #{@field[8]}"
  end

  # gets player choice and places x or o on the field
  def play_round(player)
    choice = nil
    loop do
      puts "#{player.name}, choose the avaible cell between 1 and 9:"
      choice = player_cell_input
      break if @field.include?(choice) && (choice != 'x') && (choice != 'o')
    end
    @field[@field.find_index(choice)] = player.symbol
  end

  # gets player input for cell
  def player_cell_input
    gets.chr
  end

  # checks wheter someone won
  def won?(player)
    # check vertically
    3.times do |i|
      return true if (@field[i] == player.symbol) &&
                     (@field[i + 3] == player.symbol) &&
                     (@field[i + 6] == player.symbol)
    end
    # check horizontally
    [0, 3, 6].each do |i|
      return true if (@field[i] == player.symbol) &&
                     (@field[i + 1] == player.symbol) &&
                     (@field[i + 2] == player.symbol)
    end
    # check top-left to bottom-right
    return true if (@field[0] == player.symbol) &&
                   (@field[4] == player.symbol) &&
                   (@field[8] == player.symbol)

    # check top-right to lower-left
    [0, 4, 8].each do |_i|
      return true if (@field[2] == player.symbol) &&
                     (@field[4] == player.symbol) &&
                     (@field[6] == player.symbol)
    end

    false
  end
end
