class Move
    attr_reader :player, :piece, :square
    def initialize player
        @player = player
        @piece = nil
        @square = nil
    end
end