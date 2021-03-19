class Square
    attr_reader :coordinate, :name, :piece
    def initialize coordinate
        @coordinate = coordinate[0]
        @name = coordinate[1]
        @piece = nil
    end
end