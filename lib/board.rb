# frozen_string_literal: true

class InvalidMoveError < StandardError; end

class Board
  attr_reader :grid, :pointer

  def initialize
    @grid = Array.new(6) { Array.new(7, '_') }
    @pointer = Array.new(7) { 5 }
  end

  def change_state(col, symbol)
    raise InvalidMoveError, "Invalid move: col = #{col} is a non-integer value" unless col.is_a? Integer
    raise InvalidMoveError, "Invalid move: col = #{col}" if col.negative? || col >= 7
    raise InvalidMoveError, "Invalid move: col = #{col} is already full" if pointer[col].negative?

    @grid[pointer[col]][col] = symbol
    @pointer[col] -= 1
  end

  def show
    puts
    puts(grid.map { |x| x.join(' | ') })
    puts
  end
end
