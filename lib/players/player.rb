class Player
    attr_reader :name, :color, :king
    def initialize name, color
        @name = name
        @color = color
        @king = nil
    end

    def set_king king
        @king = king
    end
end 