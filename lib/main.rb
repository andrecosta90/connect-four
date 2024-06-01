# frozen_string_literal: true

require './lib/board'
require './lib/player'
require './lib/game'

board = Board.new

# # board.change_state(5, 'O')
# # board.change_state(5, 'X')
# #
# 6.times { board.change_state(5, 'o')}

# board.show
#

# player1 = Player.new('player 1', 'O')
# player2 = Player.new('player 2', 'X')

# game = Game.new(player1, player2)
# game.run
#
# 3.times { board.change_state(5, 'O')}

# (1..4).each {|i| board.change_state(i, 'O') }

# (0..3).each do |i|
#   (i + 1).times { board.change_state(3 - i, 'O') }
# end

(1..4).each do |i|
  (i + 1).times { board.change_state(i, 'O') }
end


board.show
p board.winner_in_diagonal?('O')
