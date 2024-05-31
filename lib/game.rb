# frozen_string_literal: true

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
      @board.show
      break puts "#{@current_player.name} WINS!" if player_has_won?
      break puts "It's a TIE!" if tie?

      switch_players!
    end
  end

  private

  def player_has_won?
    false
  end

  def tie?
    @board.n_available_slots.zero?
  end

  def switch_players!
    @index = 1 - @index
    @current_player = @players[@index]
  end
end
