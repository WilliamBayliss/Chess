class Square
    attr_reader :coordinate, :name, :piece, :symbol
    def initialize coordinate
        @coordinate = coordinate[0]
        @name = coordinate[1]
        @piece = nil
        @symbol = " "
    end

    def set_piece piece
        @piece = piece
        @symbol = piece.symbol
    end

    def clear_square
        @piece = nil
        @symbol = " "
    end
end