class Move
    attr_reader :player, :opponent, :piece, :square, :board
    def initialize player
        @player = player
        @opponent = nil
        @piece = nil
        @square = nil
        @board = nil
    end

    def get_opponent player
        @opponent = player
    end

    def get_piece square
        @piece = square.piece
    end

    def get_square square
        @square = square
    end

    def get_board board
        @board = board
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