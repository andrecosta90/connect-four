# frozen_string_literal: true

require './lib/player'
require './lib/game'

player1 = Player.new('player 1', 'O')
player2 = Player.new('player 2', 'X')

game = Game.new(player1, player2)
game.run
