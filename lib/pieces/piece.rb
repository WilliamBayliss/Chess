require './lib/board/square.rb'

class Piece
    attr_accessor :square, :available_moves, :color, :symbol, :moved
    def initialize color
        @square = nil
        @color = color
        @symbol = " "
        @moved = false
        @available_moves = {}
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

    def get_move square
        @available_moves[square.name] = square
    end
end