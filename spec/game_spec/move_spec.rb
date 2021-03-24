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

        it "initializes @piece to nil" do
            move = Move.new("player_one")
            expect(move.piece).to eql(nil)
        end

        it "initializes @square to nil" do
            move = Move.new("player_one")
            expect(move.square).to eql(nil)
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
end