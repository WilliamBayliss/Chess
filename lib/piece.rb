class Piece
    attr_accessor :square, :color, :symbol
    def initialize color
        @square = nil
        @color = color
        @symbol = " "
    end

    def set_symbol symbol
        @symbol = symbol
    end

    def move square
        @square = square
    end
end