class Board
    def initialize
        @board = {}
    end

    def [](square_name)
        @board[square_name]
    end

    def add_square square
        @board[square.name] = square
    end

    def board_array
        [
            [[1,1], "A1"], [[1,2], "B1"], [[1,3], "C1"], [[1,4], "D1"], [[1,5], "E1"], [[1,6], "F1"], [[1,7], "G1"], [[1,8], "H1"], 
            [[2,1], "A2"], [[2,2], "B2"], [[2,3], "C2"], [[2,4], "D2"], [[2,5], "E2"], [[2,6], "F2"], [[2,7], "G2"], [[2,8], "H2"], 
            [[3,1], "A3"], [[3,2], "B3"], [[3,3], "C3"], [[3,4], "D3"], [[3,5], "E3"], [[3,6], "F3"], [[3,7], "G3"], [[3,8], "H3"], 
            [[4,1], "A4"], [[4,2], "B4"], [[4,3], "C4"], [[4,4], "D4"], [[4,5], "E4"], [[4,6], "F4"], [[4,7], "G4"], [[4,8], "H4"], 
            [[5,1], "A5"], [[5,2], "B5"], [[5,3], "C5"], [[5,4], "D5"], [[5,5], "E5"], [[5,6], "F5"], [[5,7], "G5"], [[5,8], "H5"], 
            [[6,1], "A6"], [[6,2], "B6"], [[6,3], "C6"], [[6,4], "D6"], [[6,5], "E6"], [[6,6], "F6"], [[6,7], "G6"], [[6,8], "H6"], 
            [[7,1], "A7"], [[7,2], "B7"], [[7,3], "C7"], [[7,4], "D7"], [[7,5], "E7"], [[7,6], "F7"], [[7,7], "G7"], [[7,8], "H7"], 
            [[8,1], "A8"], [[8,2], "B8"], [[8,3], "C8"], [[8,4], "D8"], [[8,5], "E8"], [[8,6], "F8"], [[8,7], "G8"], [[8,8], "H8"], 
        ]
    end

    def create_board board_array
        board_array.each do |coordinate|
            square = Square.new(coordinate)
            add_square(square)
        end
    end

    def print_board
        puts "
           A |  B | C | D | E | F | G | H |
        _____|____|___|___|___|___|___|___|
        1 #{@board["A1"].piece.symbol}   | #{@board["B1"].piece.symbol}   | #{@board["C1"].piece.symbol}  | #{@board["D1"].piece.symbol}  | #{@board["E1"].piece.symbol}  | #{@board["F1"].piece.symbol}  | #{@board["G1"].piece.symbol}  | #{@board["H1"].piece.symbol}  |            
        -----|----|---|---|---|---|---|---|
        2 #{@board["A2"].piece.symbol}   | #{@board["B2"].piece.symbol}   | #{@board["C2"].piece.symbol}  | #{@board["D2"].piece.symbol}  | #{@board["E2"].piece.symbol}  | #{@board["F2"].piece.symbol}  | #{@board["G2"].piece.symbol}  | #{@board["H2"].piece.symbol}  |                
        -----|----|---|---|---|---|---|---|
        3 #{@board["A3"].piece.symbol}   | #{@board["B3"].piece.symbol}   | #{@board["C3"].piece.symbol}  | #{@board["D3"].piece.symbol}  | #{@board["E3"].piece.symbol}  | #{@board["F3"].piece.symbol}  | #{@board["G3"].piece.symbol}  | #{@board["H3"].piece.symbol}  |                       
        -----|----|---|---|---|---|---|---|
        4 #{@board["A4"].piece.symbol}   | #{@board["B4"].piece.symbol}   | #{@board["C4"].piece.symbol}  | #{@board["D4"].piece.symbol}  | #{@board["E4"].piece.symbol}  | #{@board["F4"].piece.symbol}  | #{@board["G4"].piece.symbol}  | #{@board["H4"].piece.symbol}  |                    
        -----|----|---|---|---|---|---|---|
        5 #{@board["A5"].piece.symbol}   | #{@board["B5"].piece.symbol}   | #{@board["C5"].piece.symbol}  | #{@board["D5"].piece.symbol}  | #{@board["E5"].piece.symbol}  | #{@board["F5"].piece.symbol}  | #{@board["G5"].piece.symbol}  | #{@board["H5"].piece.symbol}  |                   
        -----|----|---|---|---|---|---|---|
        6 #{@board["A6"].piece.symbol}   | #{@board["B6"].piece.symbol}   | #{@board["C6"].piece.symbol}  | #{@board["D6"].piece.symbol}  | #{@board["E6"].piece.symbol}  | #{@board["F6"].piece.symbol}  | #{@board["G6"].piece.symbol}  | #{@board["H6"].piece.symbol}  |                 
        -----|----|---|---|---|---|---|---|
        7 #{@board["A7"].piece.symbol}   | #{@board["B7"].piece.symbol}   | #{@board["C7"].piece.symbol}  | #{@board["D7"].piece.symbol}  | #{@board["E7"].piece.symbol}  | #{@board["F7"].piece.symbol}  | #{@board["G7"].piece.symbol}  | #{@board["H7"].piece.symbol}  |                      
        -----|----|---|---|---|---|---|---|
        8 #{@board["A8"].piece.symbol}   | #{@board["B8"].piece.symbol}   | #{@board["C8"].piece.symbol}  | #{@board["D8"].piece.symbol}  | #{@board["E8"].piece.symbol}  | #{@board["F8"].piece.symbol}  | #{@board["G8"].piece.symbol}  | #{@board["H8"].piece.symbol}  |                     
        ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
        "
    end

    def diagonal? square, other_square
        if square.nil? || other_square.nil?
            return false
        elsif square.coordinate[0] == other_square.coordinate[0]
            return false
        elsif square.coordinate[1] == other_square.coordinate[1]
            return false
        else
            x_difference = square.coordinate[0] - other_square.coordinate[0]
            y_difference = square.coordinate[1] - other_square.coordinate[1]
            
            if x_difference / y_difference == 1 || x_difference / y_difference == -1
                return true
            else
                return false
            end
        end
    end

    def vertical? square, other_square
        if square.nil? || other_square.nil?
            return false
        elsif square.coordinate[1] == other_square.coordinate[1]
            return true
        else
            return false
        end
    end

    def horizontal? square, other_square
        if square.nil? || other_square.nil?
            return false
        elsif square.coordinate[0] == other_square.coordinate[0]
            return true
        else 
            return false
        end
    end

    def knight_move? square, other_square
        if square.nil? || other_square.nil?
            return false
          else
            if    square.coordinate[0] == (other_square.coordinate[0] + 2) && square.coordinate[1] == (other_square.coordinate[1] + 1)  
              return true
            elsif square.coordinate[0] == (other_square.coordinate[0] + 1) && square.coordinate[1] == (other_square.coordinate[1] + 2)
              return true
            elsif square.coordinate[0] == (other_square.coordinate[0] - 1) && square.coordinate[1] == (other_square.coordinate[1] + 2)
              return true
            elsif square.coordinate[0] == (other_square.coordinate[0] - 2) && square.coordinate[1] == (other_square.coordinate[1] - 1)
              return true
            elsif square.coordinate[0] == (other_square.coordinate[0] - 1) && square.coordinate[1] == (other_square.coordinate[1] - 2)
              return true
            elsif square.coordinate[0] == (other_square.coordinate[0] + 1) && square.coordinate[1] == (other_square.coordinate[1] - 2)
              return true
            elsif square.coordinate[0] == (other_square.coordinate[0] + 2) && square.coordinate[1] == (other_square.coordinate[1] -1)
              return true
            else
              return false
            end
          end
    end

end