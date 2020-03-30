require_relative 'tile'
require_relative 'board'
require 'byebug'

class Game

    def initialize
        @board = Board.new
    end

    def play
        while !@board.won
            system('clear')
            @board.render
            if self.make_choice == 'r'
                position = self.get_position
                if @board.lost(position)
                    puts "Sorry, you chose a bomb. Game over!"
                    break
                else
                    @board.mark_guess(position)
                    if @board.won
                        puts "You win!"
                    end
                end
            else
                position = self.get_position
                @board.mark_flag(position)
            end
        end
    end

    def make_choice
        print "Would you like to reveal a tile (type 'r') or flag a bomb (type 'f')? "
        input = gets.chomp
        input = self.validate_choice(input)
        input
    end

    def validate_choice(input)
        valid = false
        while valid == false
            valid = true if input == "r" || input == "f"
            if valid == false
                print "Wrong input. Try again: "
                input = gets.chomp
            end
        end
        input
    end

    def get_position
        print "Enter coordinates for the selected position, separated by a space (e.g., 1 0): "
        input = gets.chomp
        input = self.validate_position(input)
        position = input.split(" ")
        position.map! { |num| num.to_i }
        position
    end

    def validate_position(input)
        valid = false
        digits = "012345678"
        while valid == false
            valid = true 
            valid = false unless input.length == 3
            valid = false unless digits.include?(input[0])
            valid = false unless input[1] == " "
            valid = false unless digits.include?(input[2])
            if valid == false
                print "Wrong input. Try again: "
                input = gets.chomp
            end
        end
        input
    end

    def flag_bomb

    end

end

#code for testing

g = Game.new
g.play