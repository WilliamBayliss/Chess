Dir["./lib/pieces/*.rb"].each {|file| require file }
Dir["./lib/players/*.rb"].each {|file| require file }
Dir["./lib/board/*.rb"].each {|file| require file }
require './lib/game/move.rb'
require 'yaml'

class Game
    attr_accessor :board,:player_one, :player_two, :moves_history
    def initialize
        @board = nil
        @player_one = nil
        @player_two = nil
        @moves_history = []
    end

    def initial_setup
        create_board
        create_both_players
        set_player_kings(@player_one, @player_two)
    end

    def run_game
        until @board.checkmate?(@player_one.king) || @board.checkmate?(@player_two.king)
            if @moves_history.size == 0
                player_move(@player_one)
            elsif @moves_history[-1].player == @player_two
                player_move(@player_one)
            elsif @moves_history[-1].player == @player_one
                player_move(@player_two)
            end
        end
        @board.print_board
        if @board.checkmate?(@player_one.king)
            puts "Checkmate! #{player_two.name} wins."
        elsif @board.checkmate?(@player_two.king)
            puts "Checkmate! #{@player_one.name} wins."
        end
    end

    def move_piece piece, square
        if piece.available_moves[square.name] != nil
            piece.square.clear_square
            if square.piece != nil
                board.kill_piece(square.piece)
            end
            @board.place_piece(piece, square)
            piece.set_moved
            check_check


            return true
        else
            return false
        end
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
        @board.update_piece_moves
        move = Move.new(player)
        move.get_board(@board)
        @board.print_board
        
        piece = select_piece(player)
        until piece.color == player.color
            piece = select_piece(player)
        end        

        if piece.name == "King"
            if right_castle?(player) || left_castle?(player)
                puts "Would you like to castle?"
                input = gets.chomp
                until input.upcase == "Y" || input.upcase == "N"
                    puts "Please enter y for yes or n for no."
                    input = gets.chomp
                end
                if input.upcase == "Y"
                    castle(player, move)
                    record_move(move)
                    save_game
                    return
                else
                    square = select_square(piece, player)
                    move_piece(piece, square)
                    if @board.check?(player.king)
                        puts "You cannot make a move that would leave your King in check"
                        load_game
                    else
                        move.log_move_data(piece, square)
                        record_move(move)
                        save_game
                    end
                end
            else
                square = select_square(piece, player)
                move_piece(piece, square)
                if @board.check?(player.king)
                    puts "You cannot make a move that would leave your King in check"
                    load_game
                else
                    move.log_move_data(piece, square)
                    record_move(move)
                    save_game
                end
            end

        else
            square = select_square(piece, player)
            if piece.name == "Pawn" && @board.two_squares_vertical?(piece.square, square)
                move.set_pawn_jump
            end
            move_piece(piece, square)
            if @board.check?(player.king)
                puts "You cannot make a move that would leave your King in check"
                load_game
            else
                move.log_move_data(piece, square)
                record_move(move)
                save_game
            end
        end
    end

    def castle player, move
        if player.color == 0 && right_castle?(player)
            @board.castle(player.king, @board["H1"].piece)
            square = @board["H1"]
        elsif player.color == 0 && left_castle?(player)
            @board.castle(player.king, @board["A1"].piece)
            square = @board["A1"]
        elsif player.color == 1 && right_castle?(player)
            @board.castle(player.king, @board["H8"].piece)
            square = @board["H8"]
        elsif player.color == 1 && left_castle?(player)
            @board.castle(player.king, @board["A8"].piece)
            square = @board["A8"]
        end
        move.get_piece(player.king)
        move.get_square(square)
    end
    
    def right_castle?(player)
        if player.color == 0
            unless @board["H1"].piece.nil?
                if @board.castle?(player.king, @board["H1"].piece)
                    true
                else
                    false
                end
            end
        elsif player.color == 1
            unless @board["H8"].piece.nil?
                if @board.castle?(player.king, @board["H8"].piece)
                    true
                else
                    false
                end
            end
        end
    end

    def left_castle?(player)
        if player.color == 0
            unless @board["A1"].piece.nil?
                if @board.castle?(player.king, @board["A1"].piece)
                    true
                else
                    false
                end
            end
        elsif player.color == 1
            unless @board["A8"].piece.nil?    
                if @board.castle?(player.king, @board["A8"].piece)
                    true
                else
                    false
                end
            end
        end
    end
    
    def legal_move? piece, square
        if piece.available_moves.include?(square.name)
            true
        else
            false
        end
    end

    def select_piece player
        select_piece_puts(player)
        coordinate = get_coordinate
        until @board[coordinate].piece != nil
            puts "Please select a square with a piece on it"
            coordinate = get_coordinate
        end
        return @board[coordinate].piece
    end

    def select_square piece, player
        select_square_puts(player)
        coordinate = get_coordinate
        until legal_move?(piece, @board[coordinate])
            puts "Please enter a legal move for a #{piece.name}"
            coordinate = get_coordinate
        end
        return @board[coordinate]
    end

    def get_coordinate input = gets.chomp
        input.upcase!
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

    def save_game
        File.open("saves/save_game.txt", "w") do |save|
            save.write(YAML::dump(self))
        end
    end

    def load_game
        if File.exist?("saves/save_game.txt")
            game = YAML::load(File.read("saves/save_game.txt"))
            puts "Game load successful."
            game.run_game
        else
            puts "No Save File Detected Error"
        end
    end

    def start_game_puts
        puts "Welcome to Chess! This is a game of chess that you can play against a friend or the computer on the command line. Take your opponent's pieces and try to put their King into checkmate to win! \n The board is arranged by columns A-H and rows 1-8. When prompted to select a square on the board, enter the coordinate in the form column/row, i.e: A1 would select the top-left square on the board. \n Let the game begin!"
    end

    def select_piece_puts player
        puts "#{player.name}, please enter the coordinate of the piece you'd like to select."
    end

    def select_square_puts player
        puts "#{player.name}, please enter the square to move."
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

    def check_check
        if @board.check?(@player_one.king)
            puts "#{@player_one.name}, you are in check."
            return true
        elsif @board.check?(@player_two.king)
            puts "#{@player_two.name}, you are in check."
            return true
        else
            return false
        end
    end
    
end