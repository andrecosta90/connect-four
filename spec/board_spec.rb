# frozen_string_literal: true

require './lib/board'

# rubocop:disable Metrics/BlockLength
describe Board do
  describe '#change_state' do
    subject(:board) { described_class.new }
    let(:col) { 3 }
    let(:symbol) { 'X' }

    context 'when a valid move is made' do
      it 'decreases pointer p(col) by one' do
        expect { board.change_state(col, symbol) }.to change { board.pointer[col] }.by(-1)
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
  end
end
