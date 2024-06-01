# frozen_string_literal: true

require './lib/board'

# rubocop:disable Metrics/BlockLength
describe Board do
  subject(:board) { described_class.new }
  let(:col) { 3 }
  let(:symbol) { 'X' }

  describe '#change_state' do
    context 'when a valid move is made' do
      it 'decreases pointer p(col) by one' do
        expect { board.change_state(col, symbol) }.to change { board.pointer[col] }.by(-1)
      end

      it 'decreases @n_available_slots by one' do
        expect { board.change_state(col, symbol) }.to change { board.n_available_slots }.by(-1)
      end
    end

    context 'when the input is invalid' do
      shared_examples 'invalid move' do |invalid_input|
        it "raises an InvalidMoveError for input #{invalid_input.inspect}" do
          expect { board.change_state(invalid_input, symbol) }.to raise_error(InvalidMoveError)
        end
      end

      include_examples 'invalid move', -1
      include_examples 'invalid move', 10
      include_examples 'invalid move', '*'
      include_examples 'invalid move', 5.1
      include_examples 'invalid move', nil
      include_examples 'invalid move', ''
    end

    context 'when the column is already full' do
      it 'raises an InvalidMoveError' do
        6.times { board.change_state(col, symbol) }
        expect { board.change_state(col, symbol) }.to raise_error(InvalidMoveError)
      end
    end

    context 'when all columns are already full' do
      before do
        7.times do |col|
          6.times { board.change_state(col, symbol) }
        end
      end
      it 'raises an InvalidMoveError' do
        expect { board.change_state(col, symbol) }.to raise_error(InvalidMoveError)
      end

      it '@n_available_slots is equal to zero' do
        expect(board.n_available_slots).to eql(0)
      end
    end
  end

  describe '#winner?' do
    context 'when there is an winner in a column' do
      before do
        4.times { board.change_state(col, symbol) }
      end
      it 'returns true ' do
        expect(board.winner?(symbol)).to be true
      end
    end

    context 'when there is not an winner in a column' do
      before do
        2.times { board.change_state(col, symbol) }
      end
      it 'returns false' do
        expect(board.winner?(symbol)).to be false
      end
    end

    context 'when there is an winner in a row' do
      before do
        (2..5).each { |i| board.change_state(i, symbol) }
      end
      it 'returns true ' do
        expect(board.winner?(symbol)).to be true
      end
    end

    context 'when there is not an winner in a row' do
      before do
        (2..4).each { |i| board.change_state(i, symbol) }
      end
      it 'returns false' do
        expect(board.winner?(symbol)).to be false
      end
    end
    context 'when there is an winner in a descending diagonal' do
      before do
        (0..3).each do |i|
          (i + 1).times { board.change_state(3 - i, symbol) }
        end
      end
      it 'returns true ' do
        expect(board.winner?(symbol)).to be true
      end
    end

    context 'when there is not an winner in a descending diagonal' do
      before do
        (2..4).each { |i| board.change_state(i, symbol) }
      end
      it 'returns false' do
        expect(board.winner?(symbol)).to be false
      end
    end

    context 'when there is an winner in a ascending diagonal' do
      before do
        (0..3).each do |i|
          (i + 1).times { board.change_state(i, symbol) }
        end
      end
      it 'returns true ' do
        expect(board.winner?(symbol)).to be true
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
