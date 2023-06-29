# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game_one) { described_class.new }
  let(:player_one) { double(Player, name: 'player_one', symbol: 'x') }
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
end
