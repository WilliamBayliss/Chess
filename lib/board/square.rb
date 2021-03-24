class Square
    attr_reader :coordinate, :name, :piece
    def initialize coordinate
        @coordinate = coordinate[0]
        @name = coordinate[1]
        @piece = " "
    end

    def set_piece piece_symbol
        @piece = piece_symbol
    end
end