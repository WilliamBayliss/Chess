require_relative 'piece.rb'
class Bishop < Piece
    attr_accessor :name
    def initialize color
        @name = "Bishop"
        super(color)
        if @color == 0
            set_symbol("♗")
        elsif @color == 1
            set_symbol("♝")
        end
    end
end