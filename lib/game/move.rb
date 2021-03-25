class Move
    attr_reader :player, :piece, :square
    def initialize player
        @player = player
        @piece = nil
        @square = nil
    end

    def get_piece_puts
        puts "Please enter the coordinate of the piece you'd like to select."
        input = gets.chomp
        until valid_coordinate?
            input = gets.chomp
        end
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

    def get_piece square
        @piece = square.piece
    end

    def get_square square
        @square = square
    end
end