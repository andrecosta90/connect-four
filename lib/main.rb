# frozen_string_literal: true

require './lib/player'
require './lib/game'

player1 = Player.new('Player I', "\u{1F7E1}")
player2 = Player.new('Player II', "\u{1F534}")

game = Game.new(player1, player2)
game.run
