class Game
    def initialize

    end

    def create_board
        board = Board.new
        board.create_board(board.board_array)
    end
end