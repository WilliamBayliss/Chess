require_relative 'piece.rb'
class Rook < Piece
    attr_accessor :name
    def initialize color
        @name = "Rook"
        super(color)
        
        if @color == "wht"
            set_symbol("♖")
        elsif @color == "blk"
            set_symbol("♜")
        end
    end
end