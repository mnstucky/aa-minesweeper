class Tile

    attr_accessor :value, :marked
    
    def initialize(value=0)
        @value = value
        @marked = false
    end

end