# frozen_string_literal: true

require './lib/board'

board = Board.new


# board.change_state(5, 'O')
# board.change_state(5, 'X')
#
6.times { board.change_state(5, 'o')}

board.show
