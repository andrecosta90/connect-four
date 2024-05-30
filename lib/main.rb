# frozen_string_literal: true

require './lib/board'
require './lib/player'

board = Board.new

# # board.change_state(5, 'O')
# # board.change_state(5, 'X')
# #
# 6.times { board.change_state(5, 'o')}

# board.show
#

player = Player.new('andre', 'O')

6.times do
  player.make_move(board)
  board.show
end
