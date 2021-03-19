class Rook < Piece

    def legal_move? second_square
        if second_square.nil?
            return false
        elsif @square.coordinate[0] == second_square.coordinate[0]
            return true
        elsif @square.coordinate[1] == second_square.coordinate[1]
            return true
        else
            return false
        end

    end
end