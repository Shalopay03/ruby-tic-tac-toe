# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#play_round' do
    before do
      allow($stdout).to receive(:puts)
    end
    context 'when input is correct' do
      subject(:game_one) { described_class.new }
      let(:player_one) { double(Player, name: 'player_one', symbol: 'x') }
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
      subject(:game_two) { described_class.new }
      let(:player_two) { double(Player, name: 'player_two', symbol: 'x') }
      before do
        invalid_input = 'x'
        valid_input = '2'
        allow(game_two).to receive(:player_cell_input).and_return(invalid_input, valid_input)
      end

      it 'loop twice' do
        expect(game_two).to receive(:puts).with("#{player_two.name}, choose the avaible cell between 1 and 9:").exactly(2).times
        game_two.play_round(player_two)
      end

      it 'changes the field array' do
        game_two.play_round(player_two)
        expect(game_two.instance_variable_get(:@field)[1]).to eq(player_two.symbol)
      end
    end
  end
end
