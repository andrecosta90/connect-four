# frozen_string_literal: true

require './lib/game'
require './lib/player'

# rubocop:disable Metrics/BlockLength
describe Game do
  let(:first_player) { instance_double(Player, name: 'player I', symbol: 'X') }
  let(:second_player) { instance_double(Player, name: 'player II', symbol: 'O') }
  subject(:game) { described_class.new(first_player, second_player) }

  describe '#run' do
    before do
      allow(first_player).to receive(:make_move)
      allow(second_player).to receive(:make_move)
      allow(game).to receive(:show)
    end
    context 'when the first player is the winner' do
      before do
        allow(game).to receive(:player_has_won?).and_return(true)
      end
      it 'prints a win message for the first player' do
        expect(game).to receive(:puts).with("player I WINS!\n\n")
        expect(game).not_to receive(:puts).with("It's a TIE!\n\n")
        game.run
      end
    end

    context 'when second player is the winner' do
      before do
        allow(game).to receive(:player_has_won?).and_return(false, true)
      end
      it 'prints a win message for the second playe' do
        expect(game).to receive(:puts).with("player II WINS!\n\n")
        expect(game).not_to receive(:puts).with("It's a TIE!\n\n")
        game.run
      end
    end

    context 'when the game ends in a tie' do
      before do
        allow(game).to receive(:player_has_won?).and_return(false, false)
        allow(game).to receive(:tie?).and_return(false, true)
      end
      it 'prints a tie message' do
        expect(game).not_to receive(:puts).with("player I WINS!\n\n")
        expect(game).not_to receive(:puts).with("player II WINS!\n\n")
        expect(game).to receive(:puts).with("It's a TIE!\n\n")
        game.run
      end
    end

    context 'when the game continues' do
      before do
        allow(game).to receive(:player_has_won?).and_return(false, false, false)
        allow(game).to receive(:tie?).and_return(false, false, true)
      end

      it 'does not print any win or tie message' do
        expect(game).not_to receive(:puts).with("player I WINS!\n\n")
        expect(game).not_to receive(:puts).with("player II WINS!\n\n")
        expect(game).to receive(:puts).with("It's a TIE!\n\n").once
        game.run
      end
    end
  end
end
