Dir["./lib/pieces/*.rb"].each {|file| require file }
Dir["./lib/players/*.rb"].each {|file| require file }
Dir["./lib/board/*.rb"].each {|file| require file }
require './lib/game/move.rb'

class Game
    attr_accessor :board, :moves_history
    def initialize
        @board = nil
        @moves_history = []
    end

    def create_player name, color
        player = Player.new(name, color)
    end

    def create_computer_player color
        player = ComputerPlayer.new(color)
    end

    def create_board
        @board = Board.new
        @board.setup
    end

    def player_move player
        move = Move.new(player)
        move.get_board(@board)
        @board.print_board
        
        piece = select_piece
        until piece.color == player.color
            piece = select_piece
        end        
        square = select_square(piece)

        if piece.name == "Pawn" && @board.two_squares_vertical?(piece.square, square)
            move.set_pawn_jump
        end

        @board.move_piece(piece, square)
        move.log_move_data(piece, square)
        record_move(move)
    end
    
    def legal_move? piece, square
        if piece.available_moves.include?(square.name)
            true
        else
            false
        end
    end

    def select_piece
        select_piece_puts
        coordinate = get_coordinate
        return @board[coordinate].piece
    end

    def select_square piece
        select_square_puts
        coordinate = get_coordinate
        until legal_move?(piece, @board[coordinate])
            puts "Please enter a legal move for a #{piece.name}"
            coordinate = get_coordinate
        end
        return @board[coordinate]
    end

    def get_coordinate input = gets.chomp
        until valid_coordinate?(input)
            puts "Please enter a valid coordinate."
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


    def record_move move
        @moves_history.append(move)
    end

    def start_game_puts
        puts "Welcome to Chess! This is a game of chess that you can play against a friend or the computer on the command line. Take your opponent's pieces and try to put their King into checkmate to win! \n The board is arranged by columns A-H and rows 1-8. When prompted to select a square on the board, enter the coordinate in the form column/row, i.e: A1 would select the top-left square on the board. \n Let the game begin!"
    end

    def select_piece_puts
        puts "Please enter the coordinate of the piece you'd like to select."
    end

    def select_square_puts
        puts "Please enter the square to move."
    end

    def get_player_one_name_puts
        puts "Player 1, what is your name?"
    end

    def get_player_two_name_puts
        puts "Player 2, what is your name?"
    end

    def get_player_color_puts
        puts "Player 1, please select your color. Enter 0 for white or 1 for black."
    end
    
end

# game = Game.new
# game.create_board
# player_one = Player.new("William", "wht")
# game.player_move(player_one)