require_relative "square.rb"

Dir["./lib/pieces/*.rb"].each {|file| require file }

class Board
    attr_accessor :pieces
    def initialize
        @board = {}

        @pieces = []
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

    def save_piece piece_array
        piece_array.each do |piece|
            @pieces << piece
        end
    end

    def setup 
        create_board(board_array)
        add_edges
        place_pieces
        get_piece_moves
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

    def update_piece_moves last_move=nil
        get_piece_moves(last_move)
        delete_illegal_moves(last_move)
    end

    def get_piece_moves last_move=nil
        @pieces.each do |piece|
            @board.each do |key, square|
                if legal_move?(piece, square)
                    piece.get_move(square)
                end
            end
        end
    end

    def delete_illegal_moves last_move=nil
        @pieces.each do |piece|
            illegal_moves = []
            piece.available_moves.each do |name, square|
                unless legal_move?(piece, square, last_move)
                    illegal_moves.append(square)
                end
            end
            piece.update_move_list(illegal_moves)
        end
    end

    def place_piece piece, square
        piece.set_square(square)
        square.set_piece(piece)
    end

    def castle? king, rook
        if king.color == rook.color
            if king.moved == false && rook.moved == false
                if clear_path_horizontal?(king.square, rook.square)
                    if safe_to_castle?(king, rook)
                        true
                    else
                        false
                    end
                else
                    false
                end
            else
                false
            end
        else
            false
        end
    end

    def castle king, rook
        if castle?(king, rook)
            king_square = king.square
            rook_square = rook.square
            place_piece(king, rook_square)
            place_piece(rook, king_square)
            true
        else
            false
        end
    end

    def safe_to_castle? king, rook
        if under_attack?(rook, rook.square)
            return false
        else
            row = get_row(king.square)
            path = get_path_from_row(row, king.square, rook.square)
            path.each do |square|
                if under_attack?(king, square)
                    return false
                end
            end
            
        end
        true
    end

    def place_pieces
        place_white_pieces
        place_white_pawns
        place_black_pawns
        place_black_pieces
    end


    def place_white_pieces
        rook_one = Rook.new(0)
        place_piece(rook_one, @board["A1"])
        knight_one = Knight.new(0)
        place_piece(knight_one, @board["B1"])
        bishop_one = Bishop.new(0)
        place_piece(bishop_one, @board["C1"])
        queen = Queen.new(0)
        place_piece(queen, @board["D1"])
        king = King.new(0)
        place_piece(king, @board["E1"])
        bishop_two = Bishop.new(0)
        place_piece(bishop_two, @board["F1"])
        knight_two = Knight.new(0)
        place_piece(knight_two, @board["G1"])
        rook_two = Rook.new(0)
        place_piece(rook_two, @board["H1"])

        save_piece([rook_one, knight_one, bishop_one, queen, king, bishop_two, knight_two, rook_two])
    end

    def place_white_pawns
        pawn_one = Pawn.new(0)
        place_piece(pawn_one, @board["A2"])
        pawn_two = Pawn.new(0)
        place_piece(pawn_two, @board["B2"])
        pawn_three = Pawn.new(0)
        place_piece(pawn_three, @board["C2"])
        pawn_four = Pawn.new(0)
        place_piece(pawn_four, @board["D2"])
        pawn_five = Pawn.new(0)
        place_piece(pawn_five, @board["E2"])
        pawn_six = Pawn.new(0)
        place_piece(pawn_six, @board["F2"])
        pawn_seven = Pawn.new(0)
        place_piece(pawn_seven, @board["G2"])
        pawn_eight = Pawn.new(0)
        place_piece(pawn_eight, @board["H2"])
        save_piece([pawn_one, pawn_two, pawn_three, pawn_four, pawn_five, pawn_six, pawn_seven, pawn_eight])
    end

    def place_black_pieces
        rook_one = Rook.new(1)
        place_piece(rook_one, @board["A8"])
        knight_one = Knight.new(1)
        place_piece(knight_one, @board["B8"])
        bishop_one = Bishop.new(1)
        place_piece(bishop_one, @board["C8"])
        queen = Queen.new(1)
        place_piece(queen, @board["D8"])
        king = King.new(1)
        place_piece(king, @board["E8"])
        bishop_two = Bishop.new(1)
        place_piece(bishop_two, @board["F8"])
        knight_two = Knight.new(1)
        place_piece(knight_two, @board["G8"])
        rook_two = Rook.new(1)
        place_piece(rook_two, @board["H8"])
        save_piece([rook_one, knight_one, bishop_one, queen, king, bishop_two, knight_two, rook_two])

    end

    def place_black_pawns
        pawn_one = Pawn.new(1)
        place_piece(pawn_one, @board["A7"])
        pawn_two = Pawn.new(1)
        place_piece(pawn_two, @board["B7"])
        pawn_three = Pawn.new(1)
        place_piece(pawn_three, @board["C7"])
        pawn_four = Pawn.new(1)
        place_piece(pawn_four, @board["D7"])
        pawn_five = Pawn.new(1)
        place_piece(pawn_five, @board["E7"])
        pawn_six = Pawn.new(1)
        place_piece(pawn_six, @board["F7"])
        pawn_seven = Pawn.new(1)
        place_piece(pawn_seven, @board["G7"])
        pawn_eight = Pawn.new(1)
        place_piece(pawn_eight, @board["H7"])
        save_piece([pawn_one, pawn_two, pawn_three, pawn_four, pawn_five, pawn_six, pawn_seven, pawn_eight])
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
        if piece.available_moves[square.name] != nil
            piece.square.clear_square
            place_piece(piece, square)
            set_moved(piece)
            update_piece_moves()
            return true
        else
            return false
        end
    end

    def set_moved piece
        if piece.moved == false
            piece.set_moved
            true
        else
            false
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
            if x_difference.to_f / y_difference.to_f == 1 || x_difference.to_f / y_difference.to_f == -1
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

    def two_squares_vertical? square, other_square
        if square.nil? || other_square.nil?
            false
        else
            x_difference = square.coordinate[0] - other_square.coordinate[0]
            if vertical?(square, other_square) && (x_difference == 2 || x_difference == -2)
                return true
            else
                false
            end
        end
    end

    def knight_move? square, other_square
        if square.nil? || other_square.nil?
            return false
        else
            x_difference = square.coordinate[0] - other_square.coordinate[0]
            y_difference = square.coordinate[1] - other_square.coordinate[1]
            if x_difference == 2 && y_difference == -1
                true
            elsif x_difference == 2 && y_difference == 1
                true
            elsif x_difference == -2 && y_difference == -1
                true
            elsif x_difference == -2 && y_difference == 1
                true
            elsif x_difference == -1 && y_difference == 2
                true
            elsif x_difference == -1 && y_difference == -2
                true
            elsif x_difference == 1 && y_difference == -2
                true
            elsif x_difference == 1 && y_difference == 2
                true
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
        if vertical?(square, other_square)
            true
        elsif horizontal?(square, other_square)
            true
        elsif diagonal?(square, other_square)
            true
        else
            false
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
        if adjacent?(square, other_square) && !(under_attack?(square.piece, other_square))
            return true
        else
            return false
        end
    end

    # These methods are all for assessing the different conditions of moving a pawn

    # Returns true if the other square is in the correct direction for a pawn
    def pawn_direction? square, other_square
        if square.piece.symbol == "♙"
            if other_square.coordinate[0] > square.coordinate[0]
                true
            else
                false
            end
        elsif square.piece.symbol == "♟︎"
            if other_square.coordinate[0] < square.coordinate[0]
                true
            else
                false
            end
        end
    end

    # Returns true if the selected move is a legal move for a pawn
    def pawn_move? piece, square, last_move=nil
        if piece.moved == false && two_squares_vertical?(piece.square, square) && square.piece.nil?
            true
        elsif en_passant?(piece.square, last_move) && (diagonal?(piece.square, square) && adjacent?(piece.square, square))
            true
        elsif (diagonal?(piece.square, square) && adjacent?(piece.square, square)) && square.piece != nil
            true
        elsif vertical?(piece.square, square) && adjacent?(piece.square, square)
           pawn_direction?(piece.square, square)
        else
            false
        end
    end

    # Assesses the given square and the last move, returns true if the last move sets up an en passant
    def en_passant? square, last_move
        if last_move != nil
            if last_move.pawn_jump == true
                if adjacent?(square, last_move.square) && horizontal?(square, last_move.square)
                    true
                else
                    false
                end
            else
                false
            end
        else
            false
        end
    end

    # Returns true if a move is legal depending on the piece
    def legal_move? piece, square, last_move=nil
        if square.piece.nil? || square.piece.color != piece.color
            case piece.symbol

            when "♟︎", "♙"
                # Return true if square is adjacent and in the correct direction for pawn of that color
                pawn_move?(piece, square, last_move)
            when "♞", "♘"
                # Return true if move is an 'L' shape
                knight_move?(piece.square, square)
            when "♝", "♗"
                # Return true if move is diagonal and the path is not blocked by a piece
                if bishop_move?(piece.square, square) && clear_path?(piece.square, square)
                    true
                else 
                    false
                end
            when "♜", "♖"
                # Return true if move is vertical/horizontal and path not blocked by a piece
                if rook_move?(piece.square, square) && clear_path?(piece.square, square)
                    true
                else 
                    false
                end
            when "♛", "♕"
                # Return true if move is a straight line and path is not blocked by a piece
                if queen_move?(piece.square, square) && clear_path?(piece.square, square)
                    true
                else 
                    false
                end
            when "♚", "♔"
                # Return true if move is in any direction but only to an adjacent square, and the square is not under attack from a piece
                king_move?(piece.square, square)
            else
                false
            end
        else
            false
        end
    end

    # For vertical and horizontal moves, gets the row or column and evaluates each square between the start
    # and end point to make sure they have nil piece values
    # For diagonal moves, uses BFS to get a map outwards from the source and follows the path backwards from
    # The end point to make sure each piece between the end and start point has a nil piece value
    def clear_path? start_square, end_square
        if horizontal?(start_square, end_square)
            clear_path_horizontal?(start_square, end_square)
        elsif vertical?(start_square, end_square)
            clear_path_vertical?(start_square, end_square)
        else
            map = board_scan(start_square)
            next_square = map[end_square.name][:predecessor]
            until next_square == start_square
                if next_square.piece != nil
                    return false
                else
                    next_square = map[next_square.name][:predecessor]
                end
            end
            true
        end

    end



    def clear_path_horizontal? start_square, end_square
        row = get_row(start_square)
        path = get_path_from_row(row, start_square, end_square)
        path.each do |square|
            if square.piece != nil
                return false
            end
        end
        true
    end

    def get_row source
        row = {}
        @board.each do |name, square|
            if horizontal?(source, square)
                row[square.name] = square
            end
        end
        row
    end

    def get_path_from_row row, start_square, end_square
        path = []
        row.each do |name, square|
            if start_square.coordinate[1] < end_square.coordinate[1]
                if square.coordinate[1].between?(start_square.coordinate[1], end_square.coordinate[1])
                    path.append(square)
                end
            elsif end_square.coordinate[1] < start_square.coordinate[1]
                if square.coordinate[1].between?(end_square.coordinate[1], start_square.coordinate[1])
                    path.append(square)
                end
            end
        end
        path.shift
        path.pop 
        path
    end

    def clear_path_vertical? start_square, end_square
        column = get_column(start_square)
        path = get_path_from_column(column, start_square, end_square)
        path.each do |square|
            if square.piece != nil
                return false
            end
        end
        true
    end

    def get_column source
        column = {}
        @board.each do |name, square|
            if vertical?(source, square)
                column[square.name] = square
            end
        end
        column
    end

    def get_path_from_column column, start_square, end_square
        path = []
        column.each do |name, square|
            if start_square.coordinate[0] < end_square.coordinate[0]
                if square.coordinate[0].between?(start_square.coordinate[0], end_square.coordinate[0])
                    path.append(square)
                end
            elsif end_square.coordinate[0] < start_square.coordinate[0]
                if square.coordinate[0].between?(end_square.coordinate[0], start_square.coordinate[0])
                    path.append(square)
                end
            end
        end
        path.shift
        path.pop
        path
    end

    def blockable_check? piece, attack_path
        if under_attack?(piece, piece.square)
            return true
        else
            attack_path.each do |square|
                @pieces.each do |player_piece|
                    if player_piece.available_moves.include?(square)
                        return true
                    end
                end
            end 
        end
        false
    end

    def get_attack_path piece, square
        path = []
        if vertical?(piece.square, square)
            column = get_column(square)
            path = get_path_from_column(column, piece.square, square)
        elsif horizontal?(piece.square, square)
            row = get_row(square)
            path = get_path_from_row(row, piece.square, square)
        else
            map = board_scan(square)
            next_square = map[piece.square.name][:predecessor]
            until next_square == square
                path.append(next_square)
                next_square = map[next_square.name][:predecessor]
            end
        end
        path
    end

    # Uses BFS on the board to create a map of squares outward from a given square
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

    def attacks_scan piece, square
        attackers = []
        @pieces.each do |enemy|
            if enemy.available_moves[square.name] != nil && enemy.color != piece.color
                attackers.append(enemy)
            end
        end
        attackers
    end

    def under_attack? piece, square
        if attacks_scan(piece, square).length > 0
            true
        else
            false
        end
    end

    def check? king 
        if under_attack?(king, king.square)
            true
        else
            false
        end
    end

    def checkmate? king
        if any_escape?(king)
            false
        else
            attacks_array = get_attackers_and_paths(king)
            attacks_array.each do |attack_data|
                unless blockable_check?(attack_data[0], attack_data[1])
                    return true
                end
            end
            false
        end

    end

    def get_attackers_and_paths piece
        attackers_array = []

        attackers = attacks_scan(piece, piece.square)

        attackers.each do |attack|
            path = get_attack_path(attack, piece.square)
            attackers_array.append([attack, path])
        end
        attackers_array
    end

    def any_escape? king
        if king.available_moves.size == 0
            false
        else
            true
        end
    end
end