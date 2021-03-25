require './lib/game/move.rb'

describe Move do
    describe "#initialize" do
        it "initializes" do
            move = Move.new("player_one")
            expect(move).to_not eql(nil)
        end

        it "initializes @player to given value" do
            move = Move.new("player_one")
            expect(move.player).to eql("player_one")
        end

        it "initializes @opponent to nil" do
            move = Move.new('player_one')
            expect(move.opponent).to eql(nil)
        end

        it "initializes @piece to nil" do
            move = Move.new("player_one")
            expect(move.piece).to eql(nil)
        end

        it "initializes @square to nil" do
            move = Move.new("player_one")
            expect(move.square).to eql(nil)
        end
    end
    
    describe "#get_opponent" do
        it "sets @opponent" do
            player_one = Player.new("Mike", "wht")
            player_two = Player.new("Will", "blk")
            move = Move.new(player_one)
            move.get_opponent(player_two)
            expect(move.opponent).to eql(player_two)
        end
    end

    describe "#get_piece" do
        it "gets a piece from a square" do
            board = Board.new
            board.create_board(board.board_array)
            move = Move.new("player_one")
            rook = Rook.new("wht")
            board["A1"].set_piece(rook)
            move.get_piece(board["A1"])
        end
    end

    describe "#get_square" do
        it "gets the square that a piece was moved to on that turn" do
            board = Board.new
            board.create_board(board.board_array)
            move = Move.new("player_one")
            move.get_square(board["A1"])
        end
    end

    describe "#get board" do
        it "saves the board state" do
            board = Board.new
            board.create_board(board.board_array)
            move = Move.new("player_one")
            move.get_board(board)
            expect(move.board).to eql(board)
        end
    end


    describe "#valid_coordinate?" do
        it "returns false if more than two characters are entered" do
            input = "A55"
            move = Move.new("player_one")
            expect(move.valid_coordinate?(input)).to eql(false)
        end

        it "returns false if input not a valid coordinate but right length" do
            input = "J9"
            move = Move.new("player_one")
            expect(move.valid_coordinate?(input)).to eql(false)
        end

        it "returns true for a valid coordinate" do
            input = "D5"
            move = Move.new("player_one")
            expect(move.valid_coordinate?(input)).to eql(true)
        end

    end
end