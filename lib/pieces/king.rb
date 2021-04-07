require_relative 'piece.rb'

class King < Piece
    attr_accessor :name
    def initialize color
        @name = "King"
        super(color)
        if @color == "wht"
            set_symbol("♔")
        elsif @color == "blk"
            set_symbol("♚")
        end
    end
end