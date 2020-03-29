require_relative 'tile'
require_relative 'board'

class Game

    def initialize
        @board = Board.new
    end

    def play
        while !@board.won
            system('clear')
            @board.render
            position = self.process_move
            if @board.lost(position)
                puts "Sorry, you chose a bomb. Game over!"
                break
            else
                @board.mark_guess(position)
                if @board.won
                    puts "You win!"
                end
            end
        end
    end

    def get_move
        print "Enter coordinates for a position without a bomb, separated by a space (e.g., 1 0): "
        input = gets.chomp
        input
    end

    def process_move
        input = self.get_move
        position = input.split(" ")
        position.map! { |num| num.to_i }
        position
    end

end

#code for testing

g = Game.new
g.play