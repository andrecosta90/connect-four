# frozen_string_literal: true

require './lib/player'
require './lib/board'
require './lib/display'

# rubocop:disable Metrics/BlockLength
describe Player do
  describe '#valid_movement?' do
    subject(:player) { described_class.new('test', 'O') }
    let(:board) { instance_double(Board) }

    context 'when a valid move is made' do
      before do
        allow(board).to receive(:change_state).with(3, player.symbol)
      end

      it 'returns true' do
        expect(player.valid_movement?(3, board)).to be true
      end
    end

    context 'when an invalid move is made' do
      before do
        allow(board).to receive(:change_state).with(10, player.symbol).and_raise(InvalidMoveError)
      end

      it 'returns false' do
        expect(player.valid_movement?(10, board)).to be false
      end
    end
    describe '#make_move' do
      context 'when valid_movement? is false twice and true on the third attempt' do
        before do
          allow(Display).to receive(:input_message)
          allow(Display).to receive(:error_message)
          allow(player).to receive(:select_candidate)
          allow(player).to receive(:valid_movement?).and_return(false, false, true)
        end

        it 'calls valid_movement? three times' do
          expect(player).to receive(:valid_movement?).exactly(3).times
          player.make_move(board)
        end
      end

      context 'when valid_movement? is true on the first attempt' do
        before do
          allow(Display).to receive(:input_message)
          allow(Display).to receive(:error_message)
          allow(player).to receive(:select_candidate)

          allow(player).to receive(:valid_movement?).and_return(true)
        end

        it 'calls valid_movement? once' do
          expect(player).to receive(:valid_movement?).once
          player.make_move(board)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
