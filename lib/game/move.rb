class Move
    attr_reader :player, :opponent, :piece, :square, :board, :pawn_jump
    def initialize player
        @player = player
        @piece = nil
        @square = nil
        @board = nil
        @pawn_jump = false
    end

    def log_move_data piece, square
        get_piece(piece)
        get_square(square)
    end

    def get_opponent player
        @opponent = player
    end

    def select_piece coordinate
        get_piece(@board[coordinate])
    end

    def get_piece piece
        @piece = piece
    end

    def set_pawn_jump
        @pawn_jump = true
    end

    def get_square square
        @square = square
    end

    def get_board board
        @board = board
    end


end