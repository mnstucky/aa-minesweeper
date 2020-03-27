class Tile

    attr_accessor :value
    attr_reader :revealed
    
    def initialize(value=0)
        @value = value
        @revealed = false
    end

    def reveal
        @revealed = true
    end

end