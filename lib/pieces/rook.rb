require_relative 'piece.rb'
class Rook < Piece
    attr_accessor :name
    def initialize color
        @name = "Rook"
        super(color)
        
        if @color == 0
            set_symbol("♖")
        elsif @color == 1
            set_symbol("♜")
        end
    end
end