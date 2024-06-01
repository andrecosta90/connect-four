# frozen_string_literal: true

class InvalidMoveError < StandardError; end

class Board
  attr_reader :grid, :pointer, :n_available_slots, :n_columns, :n_rows

  def initialize
    @n_columns = 7
    @n_rows = 6
    @grid = Array.new(n_rows) { Array.new(n_columns, '_') }
    @pointer = Array.new(n_columns) { n_rows - 1 }
    @n_available_slots = n_rows * n_columns
  end

  def change_state(col, symbol)
    raise InvalidMoveError, "Invalid move: col = #{col} is a non-integer value" unless col.is_a? Integer
    raise InvalidMoveError, "Invalid move: col = #{col}" if col.negative? || col >= 7
    raise InvalidMoveError, "Invalid move: col = #{col} is already full" if pointer[col].negative?

    @grid[pointer[col]][col] = symbol
    @pointer[col] -= 1
    @n_available_slots -= 1
  end

  def show
    puts
    puts(grid.map { |x| x.join(' | ') })
    puts
  end

  def winner?(symbol)
    winner_in_row?(symbol) || winner_in_column?(symbol) || winner_in_diagonal?(symbol)
  end

  def tie?
    n_available_slots.zero?
  end

  private

  def winner_in_column?(symbol)
    (0...n_columns).each do |col|
      (0...(n_rows - 3)).each do |row|
        column_segment = (0..3).map { |i| grid[row + i][col] }
        return true if column_segment.all?(symbol)
      end
    end
    false
  end

  def winner_in_row?(symbol)
    (0...n_rows).each do |row|
      (0...(n_columns - 3)).each do |col|
        row_segment = (0..3).map { |i| grid[row][col + i] }
        return true if row_segment.all?(symbol)
      end
    end
    false
  end

  def winner_in_diagonal?(symbol)
    (0..(n_rows - 4)).each do |row|
      (0..(n_columns - 4)).each do |col|
        return true if winner_in_descending_diagonal?(symbol, row,
                                                      col) || winner_in_ascending_diagonal?(symbol, row, col)
      end
    end

    false
  end

  private

  # Check descending diagonals (top-left to bottom-right)
  def winner_in_descending_diagonal?(symbol, row, col)
    return true if (0..3).all? { |i| grid[row + i][col + i] == symbol }

    false
  end

  # Check ascending diagonals (bottom-left to top-right)
  def winner_in_ascending_diagonal?(symbol, row, col)
    return true if (0..3).all? { |i| grid[n_rows - row - i - 1][col + i] == symbol }

    false
  end
end
