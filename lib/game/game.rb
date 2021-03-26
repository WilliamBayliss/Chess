class Game
    attr_accessor :moves_history
    def initialize
        @moves_history = []
    end

    def create_player name, color
        player = Player.new(name, color)
    end

    def create_computer_player color
        player = ComputerPlayer.new(color)
    end

    def create_board
        board = Board.new
        board.create_board(board.board_array)
        board.place_pieces
        board
    end

    def player_move player
        move = Move.new(player)
    end

    def record_move move
        @moves_history.append(move)
    end
end