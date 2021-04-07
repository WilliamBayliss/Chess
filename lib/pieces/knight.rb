require_relative 'piece.rb'

class Knight < Piece
    attr_accessor :name
    def initialize color
        @name = "Knight"
        super(color)
        
        if @color == "wht"
            set_symbol("♘")
        elsif @color == "blk"
            set_symbol("♞")
        end
    end
end