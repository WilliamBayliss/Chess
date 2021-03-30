require_relative 'piece.rb'
class Pawn < Piece

    def initialize color
        super(color)
        if @color == "wht"
            set_symbol("♙")
        elsif @color == "blk"
            set_symbol("♟︎")
        end
    end

    def set_moved
        @moved = true
    end

    def register_en_passant move
        @en_passant = move
    end
end