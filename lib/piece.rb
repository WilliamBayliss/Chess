class Piece
    attr_accessor :square, :symbol
    def initialize square
        @square = square
        @symbol = nil
    end

    def set_symbol symbol
        @symbol = symbol
    end

    def move square
        @square = square
    end
end