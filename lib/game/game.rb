class Game
    attr_accessor :moves_history
    def initialize
        @moves_history = []
    end

    def create_board
        board = Board.new
        board.create_board(board.board_array)

        board
    end

    def record_move move
        @moves_history.append(move)
    end
end