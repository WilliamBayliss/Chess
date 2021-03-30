require './lib/board/square.rb'

class Piece
    attr_accessor :square, :color, :symbol, :moved
    def initialize color
        @square = nil
        @color = color
        @symbol = " "
        @moved = false
    end

    def set_symbol symbol
        @symbol = symbol
    end

    def set_square square
        @square = square
    end

    def set_moved
        @moved = true
    end
end