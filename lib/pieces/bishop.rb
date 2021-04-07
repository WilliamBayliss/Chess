require_relative 'piece.rb'
class Bishop < Piece
    attr_accessor :name
    def initialize color
        @name = "Bishop"
        super(color)
        if @color == "wht"
            set_symbol("♗")
        elsif @color == "blk"
            set_symbol("♝")
        end
    end
end