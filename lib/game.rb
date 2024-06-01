# frozen_string_literal: true

require './lib/board'

class Game
  def initialize(first_player, second_player)
    @board = Board.new
    @players = [first_player, second_player]
    @index = 0
    @current_player = @players[@index]
  end

  def run
    loop do
      @current_player.make_move(@board)
      show
      break puts "#{current_player_name} WINS!" if player_has_won?
      break puts "It's a TIE!" if tie?

      switch_players!
    end
  end

  def show
    @board.show
  end

  def tie?
    @board.tie?
  end

  def player_has_won?
    @board.winner?
  end

  def current_player_name
    @current_player.name
  end

  private

  def switch_players!
    @index = 1 - @index
    @current_player = @players[@index]
  end
end
