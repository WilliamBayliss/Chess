Dir["./lib/pieces/*.rb"].each {|file| require file }
Dir["./lib/players/*.rb"].each {|file| require file }
Dir["./lib/game/*.rb"].each {|file| require file }
Dir["./lib/board/*.rb"].each {|file| require file }

class Game
    attr_accessor :moves_history
    def initialize
        @board = create_board
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
        board.setup
        board
    end

    def player_move player
        @board.print_board
        move = Move.new(player)
        move.get_board(@board)
        move.select_piece
        move.select_square
        move.piece.move(move.square)
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


    def record_move move
        @moves_history.append(move)
    end

    def start_game_puts
        puts "Welcome to Chess! This is a game of chess that you can play against a friend or the computer on the command line. Take your opponent's pieces and try to put their King into checkmate to win!"
    end
end