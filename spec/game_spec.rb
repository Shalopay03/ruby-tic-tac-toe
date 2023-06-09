# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game_one) { described_class.new }
  let(:player_one) { double(Player, name: 'player_one', symbol: 'x') }
  let(:player_two) { double(Player, name: 'player_two', symbol: 'o') }
  describe '#play_round' do
    before do
      allow($stdout).to receive(:puts)
    end
    context 'when input is correct' do
      let(:input) { '2' }
      before do
        allow(game_one).to receive(:player_cell_input).and_return(input)
      end

      it 'loop only once' do
        expect(game_one).to receive(:puts).with("#{player_one.name}, choose the avaible cell between 1 and 9:").exactly(1).times
        game_one.play_round(player_one)
      end

      it 'changes the field array' do
        game_one.play_round(player_one)
        expect(game_one.instance_variable_get(:@field)[1]).to eq(player_one.symbol)
      end
    end

    context 'when input is incorrect once' do
      before do
        invalid_input = 'x'
        valid_input = '2'
        allow(game_one).to receive(:player_cell_input).and_return(invalid_input, valid_input)
      end

      it 'loop twice' do
        expect(game_one).to receive(:puts).with("#{player_one.name}, choose the avaible cell between 1 and 9:").exactly(2).times
        game_one.play_round(player_one)
      end

      it 'changes the field array' do
        game_one.play_round(player_one)
        expect(game_one.instance_variable_get(:@field)[1]).to eq(player_one.symbol)
      end
    end
  end

  describe '#won?' do
    context "when didn't win" do
      it 'returns false' do
        expect(game_one.won?(player_one)).to eq(false)
      end
    end
    context "when 3 x's in a horizontal row" do
      it 'returns true' do
        game_one.instance_variable_set(:@field, %w[x x x 4 5 6 7 8 9])
        expect(game_one.won?(player_one)).to eq(true)
      end
    end
    context "when 3 x's in a vertical row" do
      it 'returns true' do
        game_one.instance_variable_set(:@field, %w[x 2 3 x 5 6 x 8 9])
        expect(game_one.won?(player_one)).to eq(true)
      end
    end
    context "when 3 x's are from top left to borrom right" do
      it 'returns true' do
        game_one.instance_variable_set(:@field, %w[x 2 3 4 x 6 7 8 x])
        expect(game_one.won?(player_one)).to eq(true)
      end
    end
  end

  describe '#play' do
    context 'plays rounds' do
      before do
        allow(game_one).to receive(:won?).and_return(false)
        allow(game_one).to receive(:show_field)
        allow(game_one).to receive(:play_round)
      end
      it 'checks whether players won' do
        expect(game_one).to receive(:won?).at_least(2).times
        game_one.play(player_one, player_two)
      end
      it 'outputs field after each round' do
        expect(game_one).to receive(:show_field).at_least(2).times
        game_one.play(player_one, player_two)
      end
      it 'plays rounds' do
        expect(game_one).to receive(:play_round).at_least(2).times
        game_one.play(player_one, player_two)
      end
    end
    context 'If player 2 wins on fourth turn' do
      before do
        allow(game_one).to receive(:won?).with(player_two).and_return(false, false, false, true)
        allow(game_one).to receive(:won?).with(player_one).and_return(false, false, false, false)
        allow(game_one).to receive(:show_field)
        allow(game_one).to receive(:play_round)
      end
      it 'loops 4 times' do
        expect(game_one.play(player_one, player_two)).to eq(player_two.name)
      end
    end
  end
end
