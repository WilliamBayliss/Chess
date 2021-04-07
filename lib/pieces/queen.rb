require_relative 'piece.rb'
class Queen < Piece
    attr_accessor :name
    def initialize color
        @name = "Queen"
        super(color)
        
        if @color == "wht"
            set_symbol("♕")
        elsif @color == "blk"
            set_symbol("♛")
        end
    end
end