require_relative 'piece.rb'
class Pawn < Piece
    attr_accessor :moved
    
    def initialize color
        super(color)
        @moved = false
        if @color == "wht"
            set_symbol("♙")
        elsif @color == "blk"
            set_symbol("♟︎")
        end
    end

    def set_moved
        @moved = true
    end
end