require_relative 'piece.rb'
class Pawn < Piece
    attr_accessor :name
    def initialize color
        @name = "Pawn"
        super(color)
        if @color == 0
            set_symbol("♙")
        elsif @color == 1
            set_symbol("♟︎")
        end
    end

end