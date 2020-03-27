require_relative 'tile'

class Board

    attr_reader :grid

    def initialize
        @grid = Array.new(9) { Array.new(9) }
        self.fill_grid
        self.seed_grid
    end

    def fill_grid
        (0...@grid.length).each do |idx1|
            (0...@grid.length).each do |idx2|
                @grid[idx1][idx2] = Tile.new
            end
        end
    end

    def seed_grid
        count = 0
        while count < 10
            idx1 = rand(9)
            idx2 = rand(9)            
            tile = @grid[idx1][idx2]
            if tile.value != "B"
                tile.value = "B"
                count += 1
                (-1..1).each do |i|
                    (-1..1).each do |j|
                        if idx1+i >= 0 && idx1+i < 9 && idx2+j >= 0 && idx2+j < 9
                            @grid[idx1+i][idx2+j].value += 1 if @grid[idx1+i][idx2+j].value != "B"
                        end
                    end
                end
            end
        end
    end

    def render
        print "  0 1 2 3 4 5 6 7 8"
        puts
        @grid.each.with_index do |row, idx|
            print "#{idx} "
            row.each do |tile| 
                if tile.revealed
                    print tile.value + " "
                else
                    print "_ "
                end
            end
            puts
        end
    end

end

#code for testing

b = Board.new
b.render