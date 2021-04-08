class Move
    attr_reader :player, :opponent, :piece, :square, :board, :pawn_jump
    def initialize player
        @player = player
        @opponent = nil
        @piece = nil
        @square = nil
        @board = nil
        @pawn_jump = false
    end

    def log_move_data board, opponent, piece, square
        get_board(board)
        get_opponent(opponent)
        get_piece(piece)
        get_square(square)
    end

    def get_opponent player
        @opponent = player
    end

    def select_piece coordinate
        get_piece(@board[coordinate])
    end

    def get_piece square
        @piece = square.piece
    end

    def set_pawn_jump
        @pawn_jump = true
    end

    def select_piece
        get_piece_puts
        coordinate = get_coordinate
        until @board[coordinate].piece != nil
            puts "Please select a piece on the board"
            coordinate = get_coordinate
        end
    end

    def select_square
        get_square_puts
        coordinate = get_coordinate
        until @piece.available_moves.include?(coordinate)
            puts "That is an illegal move, please choose again"
            coordinate = get_coordinate
        end

        get_square(@board[coordinate])

    end

    def get_square square
        @square = square
    end

    def get_board board
        @board = board
    end

    def get_coordinate
        input = gets.chomp
        until valid_coordinate?(input)
            input = gets.chomp
        end
        input
    end

    def valid_coordinate? input
        input = input.split("")
        if input.length > 2
            return false
        elsif input[0] =~ /[A-H]/ && input[1] =~ /[1-8]/
            return true
        else
            return false
        end
    end

    def get_piece_puts
        puts "Please enter the coordinate of the piece you'd like to select."
    end

    def get_square_puts piece
        puts "Please enter the coordinate to move #{piece.name} to."
    end

end