class Square
    attr_reader :coordinate, :name, :piece
    def initialize coordinate
        @coordinate = coordinate
        @name = nil
        @piece = nil
    end
end