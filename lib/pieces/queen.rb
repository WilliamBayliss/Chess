require_relative 'piece.rb'
class Queen < Piece
    attr_accessor :name
    def initialize color
        @name = "Queen"
        super(color)
        
        if @color == 0
            set_symbol("♕")
        elsif @color == 1
            set_symbol("♛")
        end
    end
end