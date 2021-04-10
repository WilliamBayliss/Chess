require_relative 'piece.rb'

class King < Piece
    attr_accessor :name
    def initialize color
        @name = "King"
        super(color)
        if @color == 0
            set_symbol("♔")
        elsif @color == 1
            set_symbol("♚")
        end
    end
end