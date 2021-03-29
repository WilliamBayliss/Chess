class Square
    attr_reader :coordinate, :neighbours, :name, :piece, :symbol
    def initialize coordinate
        @coordinate = coordinate[0]
        @name = coordinate[1]
        @neighbours = []
        @piece = nil
        @symbol = " "
    end

    def add_neighbour square
        @neighbours << square
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