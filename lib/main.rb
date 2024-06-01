# frozen_string_literal: true

require './lib/player'
require './lib/game'



player1 = Player.new('André', "\u{1F7E1}")
player2 = Player.new('Vanessa', "\u{1F534}")

game = Game.new(player1, player2)
game.run
