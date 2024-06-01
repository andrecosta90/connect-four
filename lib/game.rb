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
    final_message = ''
    loop do
      show

      @current_player.make_move(@board)

      break final_message = "Congratulations #{current_player_name}! You won!\n\n" if player_has_won?
      break final_message = "It's a tie!\n\n" if tie?

      switch_players!
    end
    show
    puts final_message
  end

  def show
    Display.print_header
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
