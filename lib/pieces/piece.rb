require './lib/board/square.rb'

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

    def set_square square
        @square = square
    end
end