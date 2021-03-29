class Move
    attr_reader :player, :opponent, :piece, :square, :board
    def initialize player
        @player = player
        @opponent = nil
        @piece = nil
        @square = nil
        @board = nil
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

    def select_piece
        puts "Which piece would you like to move?"
        coordinate = get_coordinate
        get_piece(@board[coordinate])
    end

    def get_piece square
        @piece = square.piece
    end

    def select_square
        puts "Where are you going to move the piece?"
        coordinate = get_coordinate
        until @board.legal_move?(piece.square, @board[coordinate])
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
        puts "Please enter a coordinate to select a square"
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
        input = gets.chomp
        until valid_coordinate?(input)
            input = gets.chomp
        end
    end

end