require_relative "square.rb"

Dir["./lib/pieces/*.rb"].each {|file| require file }

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

    def place_pieces
        place_white_pieces
        place_black_pieces
    end

    def place_white_pieces
        
    end

    def print_board
        puts "
         |  A |  B |  C |  D |  E |  F |  G |  H |
         |____|____|____|____|____|____|____|____|
         |    |    |    |    |    |    |    |    |
        1| #{@board["A1"].symbol}  | #{@board["B1"].symbol}  | #{@board["C1"].symbol}  | #{@board["D1"].symbol}  | #{@board["E1"].symbol}  | #{@board["F1"].symbol}  | #{@board["G1"].symbol}  | #{@board["H1"].symbol}  |            
         |____|____|____|____|____|____|____|____|
         |    |    |    |    |    |    |    |    |
        2| #{@board["A2"].symbol}  | #{@board["B2"].symbol}  | #{@board["C2"].symbol}  | #{@board["D2"].symbol}  | #{@board["E2"].symbol}  | #{@board["F2"].symbol}  | #{@board["G2"].symbol}  | #{@board["H2"].symbol}  |                
         |____|____|____|____|____|____|____|____|
         |    |    |    |    |    |    |    |    |
        3| #{@board["A3"].symbol}  | #{@board["B3"].symbol}  | #{@board["C3"].symbol}  | #{@board["D3"].symbol}  | #{@board["E3"].symbol}  | #{@board["F3"].symbol}  | #{@board["G3"].symbol}  | #{@board["H3"].symbol}  |                       
         |____|____|____|____|____|____|____|____|
         |    |    |    |    |    |    |    |    |
        4| #{@board["A4"].symbol}  | #{@board["B4"].symbol}  | #{@board["C4"].symbol}  | #{@board["D4"].symbol}  | #{@board["E4"].symbol}  | #{@board["F4"].symbol}  | #{@board["G4"].symbol}  | #{@board["H4"].symbol}  |                    
         |____|____|____|____|____|____|____|____|
         |    |    |    |    |    |    |    |    |
        5| #{@board["A5"].symbol}  | #{@board["B5"].symbol}  | #{@board["C5"].symbol}  | #{@board["D5"].symbol}  | #{@board["E5"].symbol}  | #{@board["F5"].symbol}  | #{@board["G5"].symbol}  | #{@board["H5"].symbol}  |                   
         |____|____|____|____|____|____|____|____|
         |    |    |    |    |    |    |    |    |
        6| #{@board["A6"].symbol}  | #{@board["B6"].symbol}  | #{@board["C6"].symbol}  | #{@board["D6"].symbol}  | #{@board["E6"].symbol}  | #{@board["F6"].symbol}  | #{@board["G6"].symbol}  | #{@board["H6"].symbol}  |                 
         |____|____|____|____|____|____|____|____|
         |    |    |    |    |    |    |    |    |
        7| #{@board["A7"].symbol}  | #{@board["B7"].symbol}  | #{@board["C7"].symbol}  | #{@board["D7"].symbol}  | #{@board["E7"].symbol}  | #{@board["F7"].symbol}  | #{@board["G7"].symbol}  | #{@board["H7"].symbol}  |                      
         |____|____|____|____|____|____|____|____|
         |    |    |    |    |    |    |    |    |
        8| #{@board["A8"].symbol}  | #{@board["B8"].symbol}  | #{@board["C8"].symbol}  | #{@board["D8"].symbol}  | #{@board["E8"].symbol}  | #{@board["F8"].symbol}  | #{@board["G8"].symbol}  | #{@board["H8"].symbol}  |                     
         |____|____|____|____|____|____|____|____|
        "
    end

    def move_piece piece, square
        if legal_move?(piece, square)
            piece.square.clear_square
            piece.set_square(square)
            square.set_piece(piece)
            return true
        else
            return false
        end
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

    def adjacent? square, other_square
        if square.nil? || other_square.nil?
            return false
        else
            x_difference = square.coordinate[0] - other_square.coordinate[0]
            y_difference = square.coordinate[1] - other_square.coordinate[1]
            if (x_difference <= 1 && x_difference >= -1) && (y_difference <= 1 && y_difference >= -1)
                return true
            else
                return false
            end
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

    def rook_move? square, other_square
        if vertical?(square, other_square) || horizontal?(square, other_square)
            return true
        else
            return false
        end
    
    end

    def queen_move? square, other_square
        if vertical?(square, other_square) || horizontal?(square, other_square) || diagonal?(square, other_square)
            return true
        else
            return false     
        end
    end

    def bishop_move? square, other_square
        if diagonal?(square, other_square)
            return true
        else
            return false
        end
    end

    def king_move? square, other_square
        if adjacent?(square, other_square)
            return true
        else
            return false
        end
    end

    def pawn_move? pawn, square, other_square
        if vertical?(square, other_square) && adjacent?(square, other_square)
            if pawn.symbol == "♙"
                if other_square.coordinate[0] < square.coordinate[0]
                    return true
                else
                    return false
                end
            elsif pawn.symbol == "♟︎"
                if other_square.coordinate[0] > square.coordinate[0]
                    return true
                else
                    return false
                end
            end
        else
            return false
        end

    end

    def legal_move? piece, square
        case piece.symbol
        when "♟︎", "♙"
            pawn_move?(piece, piece.square, square)
        when "♞", "♘"
            knight_move?(piece.square, square)
        when "♝", "♗"
            bishop_move?(piece.square, square)
        when "♜", "♖"
            rook_move?(piece.square, square)
        when "♛", "♕"
            queen_move?(piece.square, square)
        when "♚", "♔"
            king_move?(piece.square, square)
        else
            false
        end
    end

end