# frozen_string_literal: true

require './lib/display'

# Represents a player in a game.
# Each player has a name, a symbol representing their marker on the board,
# and a reference to the game board.
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def valid_movement?(col, board)
    board.change_state(col, symbol)
    true
  rescue InvalidMoveError
    false
  end

  def make_move(board)
    loop do
      Display.input_message(name, symbol)
      col = select_candidate(board)
      return { column: col } if valid_movement?(col, board)

      Display.error_message
    end
  end

  # private

  def select_candidate(_)
    gets.to_i - 1
  end
end

# Represents a computer player that makes random moves on the board.
# Inherits from the Player class.
class DumbPlayer < Player
  private

  def select_candidate(board)
    sleep(1)
    (0...board.n_columns).to_a.sample
  end
end
