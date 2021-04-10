Dir["./lib/pieces/*.rb"].each {|file| require file }
Dir["./lib/players/*.rb"].each {|file| require file }
Dir["./lib/board/*.rb"].each {|file| require file }
require './lib/game/move.rb'

class Game
    attr_accessor :board,:player_one, :player_two, :moves_history
    def initialize
        @board = nil
        @player_one = nil
        @player_two = nil
        @moves_history = []
    end

    def create_both_players
        create_player_one
        create_player_two(@player_one)
    end

    def create_player_one
        get_player_one_name_puts
        name = gets_player_name
        get_player_color_puts
        color = gets_player_color
        @player_one = create_player(name, color)
    end

    def create_player_two player_one
        get_player_two_name_puts
        name = gets_player_name
        if player_one.color == 0
            color = 1
        elsif player_one.color == 1
            color = 0
        end
        @player_two = create_player(name, color)
    end

    def create_player name, color
        player = Player.new(name, color)
        player
    end

    def gets_player_name
        input = gets.chomp
        input
    end

    def gets_player_color
        input = gets.chomp.to_i
        until input == 1 || input == 2
            puts "Invalid input, please enter 1 or 2 for white or black"
            input = gets.chomp.to_i
        end
        return input - 1
    end

    def create_computer_player color
        player = ComputerPlayer.new(color)
    end

    def create_board
        @board = Board.new
        @board.setup
    end

    def set_player_kings player_one, player_two
        if player_one.color == 0
            player_one.set_king(@board["E1"].piece)
            player_two.set_king(@board["E8"].piece)
        elsif player_one.color == 1
            player_one.set_king(@board["E8"].piece)
            player_two.set_king(@board["E1"].piece)
        end
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
        puts "Player 1, please select your color. Enter 1 for white or 2 for black."
    end
    
end