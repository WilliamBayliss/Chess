class Move
    attr_reader :player, :piece, :square
    def initialize player
        @player = player
        @piece = nil
        @square = nil
    end

    def get_piece square
        @piece = square.piece
    end

    def get_square square
        @square = square
    end
end