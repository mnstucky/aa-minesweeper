class Tile

    attr_accessor :value, :guessed, :flagged
    
    def initialize(value=0)
        @value = value
        @guessed = false
        @flagged = false
    end

end