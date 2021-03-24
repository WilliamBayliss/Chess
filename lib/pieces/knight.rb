require './piece.rb'

class Knight < Piece
    def initialize color
        super(color)
        
        if @color == "wht"
            set_symbol("♘")
        elsif @color == "blk"
            set_symbol("♞")
        end
    end
end