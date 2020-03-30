require_relative 'tile'
require_relative 'board'
require 'yaml'

class Game

    def initialize
        choice = self.get_start
        if choice == "l"
            self.load_game
            self.play
        else
            @board = Board.new
            self.play
        end
    end

    def get_start
        print "Welcome to minesweeper! Would you like to load a game (type 'l') or start a new game (type 'n')?"
        input = gets.chomp
        input = self.validate_start(input)
        input
    end
    
    def validate_start(input)
        valid = false
        while valid == false
            valid = true if input == "l" || input == "n"
            if valid == false
                print "Wrong input. Try again: "
                input = gets.chomp
            end
        end
        input
    end

    def play
        while !@board.won
            system('clear')
            @board.render
            choice = self.make_choice
            if choice == "r"
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
            elsif choice == "f"
                position = self.get_position
                @board.mark_flag(position)
            else
                self.save_game
            end
        end
    end

    def make_choice
        print "Would you like to reveal a tile (type 'r'), flag a bomb (type 'f'), or save your game (type 's')? "
        input = gets.chomp
        input = self.validate_choice(input)
        input
    end

    def validate_choice(input)
        valid = false
        while valid == false
            valid = true if input == "r" || input == "f" || input == "s"
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

    def save_game
        serialized_board = YAML::dump(@board)
        file = File.open("savegame.yml", "w")
        file.puts serialized_board
        file.close
    end

    def load_game
        @board = YAML.load_file("savegame.yml")
    end

end

#code for testing

g = Game.new