# frozen_string_literal: true

class Display
  def self.header
    system 'clear'
    puts <<~ASCII
       ####      #
      #    #    ##
      #        # #
      #       #  #
      #      #######
      #    #     #
       ####      #\n\n
    ASCII
  end

  def self.show(grid)
    # print_header

    puts "|----+----+----+----+----+----+----|\n|  1 |  2 |  3 |  4 |  5 |  6 |  7 |\n|----+----+----+----+----+----+----|\n"

    6.times do |row|
      print '|'
      7.times do |col|
        print " #{grid[row][col]} |"
      end
      puts
      puts '|----+----+----+----+----+----+----|' # unless row == 5
    end
    puts "\n\n"
  end

  def self.final_message(result, name)
    # "\e[#{color_code}m#{self}\e[0m"
    return puts "\e[36mCongratulations #{name}! You won!\e[0m\n\n" if result == 2

    puts "It's a tie!\n\n" if result == 1
  end

  def self.input_message(name, symbol)
    puts "Waiting for #{name} ( #{symbol} ) :"
  end

  def self.error_message
    puts '\e[47mInvalid move! Try again!\e[0m'
  end
end
