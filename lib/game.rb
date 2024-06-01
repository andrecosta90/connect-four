# frozen_string_literal: true

require './lib/board'
require './lib/display'

class Game
  def initialize(first_player, second_player)
    @board = Board.new
    @players = [first_player, second_player]
    @index = 0
    @current_player = @players[@index]
  end

  def run
    result = 0
    loop do
      show

      @current_player.make_move(@board)

      break result = 2 if player_has_won?
      break result = 1 if tie?

      switch_players!
    end
    show
    final_message(result, current_player_name)
  end

  def final_message(result, current_player_name)
    Display.final_message(result, current_player_name)
  end

  def show
    Display.header
    Display.show(@board.grid)
  end

  def tie?
    @board.tie?
  end

  def player_has_won?
    @board.winner?(@current_player.symbol)
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
