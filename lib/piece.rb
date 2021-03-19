class Piece
    attr_accessor :square
    def initialize square
        @square = square
    end

    def move square
        @square = square
    end

    def diagonal? other_square
        if other_square.nil?
            return false
        elsif @square.coordinate[0] != other_square.coordinate[0] && @square.coordinate[1] != other_square.coordinate[1]
            return true
        else 
            return false
        end
    end
end