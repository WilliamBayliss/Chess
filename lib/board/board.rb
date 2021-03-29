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

    def add_edge(square, neighbour)
        @board[square].add_neighbour(@board[neighbour])
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

    def add_edges
        @board.each_key do |key|
            @board.each_key do |other_key|
                if adjacent?(@board[key], @board[other_key])
                    add_edge(key, other_key)
                end
            end
        end
    end

    def place_pieces
        place_white_pieces
        place_white_pawns
        place_black_pawns
        place_black_pieces
    end

    def place_white_pieces
        rook_one = Rook.new("wht")
        @board["A1"].set_piece(rook_one)
        knight_one = Knight.new("wht")
        @board["B1"].set_piece(knight_one)
        bishop_one = Bishop.new("wht")
        @board["C1"].set_piece(bishop_one)
        king = King.new("wht")
        @board["D1"].set_piece(king)
        queen = Queen.new("wht")
        @board["E1"].set_piece(queen)
        bishop_two = Bishop.new("wht")
        @board["F1"].set_piece(bishop_two)
        knight_two = Knight.new("wht")
        @board["G1"].set_piece(knight_two)
        rook_two = Rook.new("wht")
        @board["H1"].set_piece(rook_two)
    end

    def place_white_pawns
        pawn_one = Pawn.new("wht")
        @board["A2"].set_piece(pawn_one)
        pawn_two = Pawn.new("wht")
        @board["B2"].set_piece(pawn_two)
        pawn_three = Pawn.new("wht")
        @board["C2"].set_piece(pawn_three)
        pawn_four = Pawn.new("wht")
        @board["D2"].set_piece(pawn_four)
        pawn_five = Pawn.new("wht")
        @board["E2"].set_piece(pawn_five)
        pawn_six = Pawn.new("wht")
        @board["F2"].set_piece(pawn_six)
        pawn_seven = Pawn.new("wht")
        @board["G2"].set_piece(pawn_seven)
        pawn_eight = Pawn.new("wht")
        @board["H2"].set_piece(pawn_eight)
    end

    def place_black_pieces
        rook_one = Rook.new("blk")
        @board["A8"].set_piece(rook_one)
        knight_one = Knight.new("blk")
        @board["B8"].set_piece(knight_one)
        bishop_one = Bishop.new("blk")
        @board["C8"].set_piece(bishop_one)
        king = King.new("blk")
        @board["D8"].set_piece(king)
        queen = Queen.new("blk")
        @board["E8"].set_piece(queen)
        bishop_two = Bishop.new("blk")
        @board["F8"].set_piece(bishop_two)
        knight_two = Knight.new("blk")
        @board["G8"].set_piece(knight_two)
        rook_two = Rook.new("blk")
        @board["H8"].set_piece(rook_two)
    end

    def place_black_pawns
        pawn_one = Pawn.new("blk")
        @board["A7"].set_piece(pawn_one)
        pawn_two = Pawn.new("blk")
        @board["B7"].set_piece(pawn_two)
        pawn_three = Pawn.new("blk")
        @board["C7"].set_piece(pawn_three)
        pawn_four = Pawn.new("blk")
        @board["D7"].set_piece(pawn_four)
        pawn_five = Pawn.new("blk")
        @board["E7"].set_piece(pawn_five)
        pawn_six = Pawn.new("blk")
        @board["F7"].set_piece(pawn_six)
        pawn_seven = Pawn.new("blk")
        @board["G7"].set_piece(pawn_seven)
        pawn_eight = Pawn.new("blk")
        @board["H7"].set_piece(pawn_eight)
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
                if other_square.coordinate[0] > square.coordinate[0]
                    return true
                else
                    return false
                end
            elsif pawn.symbol == "♟︎"
                if other_square.coordinate[0] < square.coordinate[0]
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

    def clear_path? path
        result = true
        path.each do |square|
            if square.piece != nil
                result = false
            end
        end
        result
    end

    def board_scan source
        map = {}

        @board.each do |(key, value)|
            map[key] = {
                predecessor: nil,
                distance: nil
            }
        end

        map[source.name][:distance] = 0

        queue = []
        queue.append(source)

        while queue.length > 0
            temp =  queue[0]
            queue.shift

            temp.neighbours.each do |neighbour|
                if map[neighbour.name][:distance].nil?
                    map[neighbour.name][:distance] = map[temp.name][:distance] + 1
                    map[neighbour.name][:predecessor] = temp

                    queue.append(neighbour)
                end
            end
        end
        map
    end 

end