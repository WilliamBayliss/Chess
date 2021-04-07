require_relative 'piece.rb'
class Pawn < Piece
    attr_accessor :name
    def initialize color
        @name = "Pawn"
        super(color)
        if @color == "wht"
            set_symbol("♙")
        elsif @color == "blk"
            set_symbol("♟︎")
        end
    end

end