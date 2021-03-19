require './piece.rb'

class Knight < Piece


    def legal_move? square_two
        if    @square.coordinate[0] == (square_two.coordinate[0] + 2) && @square.coordinate[1] == (square_two.coordinate[1] + 1)  
          return true
        elsif @square.coordinate[0] == (square_two.coordinate[0] + 1) && @square.coordinate[1] == (square_two.coordinate[1] + 2)
          return true
        elsif @square.coordinate[0] == (square_two.coordinate[0] - 1) && @square.coordinate[1] == (square_two.coordinate[1] + 2)
          return true
        elsif @square.coordinate[0] == (square_two.coordinate[0] - 2) && @square.coordinate[1] == (square_two.coordinate[1] - 1)
          return true
        elsif @square.coordinate[0] == (square_two.coordinate[0] - 1) && @square.coordinate[1] == (square_two.coordinate[1] - 2)
          return true
        elsif @square.coordinate[0] == (square_two.coordinate[0] + 1) && @square.coordinate[1] == (square_two.coordinate[1] - 2)
          return true
        elsif @square.coordinate[0] == (square_two.coordinate[0] + 2) && @square.coordinate[1] == (square_two.coordinate[1] -1)
          return true
        else
          return false
        end
    end
end