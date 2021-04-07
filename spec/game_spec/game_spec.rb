require './lib/game/game.rb'
describe Game do
    describe "#initialize" do
        it "initializes" do
            game = Game.new
            expect(game).to_not eql(nil)
        end

        it "initializes moves_history to empty array" do
            game = Game.new
            expect(game.moves_history).to eql([])
        end
    end

    describe "#create_computer_player" do
        it "returns the computer player" do
            game = Game.new
            cpu = game.create_computer_player("wht")

            expect(cpu).to_not eql(nil)
        end

        it "gives the player a name of 'CPU' " do
            game = Game.new
            cpu = game.create_computer_player("wht")
            expect(cpu.name).to eql("CPU")
        end

    end


    describe "#record_move" do
        it "adds a move to the @move_history" do
            game = Game.new
            move = Move.new("player_one")
            game.record_move(move)
            expect(game.moves_history[-1]).to eql(move)
        end

        it "allows the player in a move to be accessed" do
            game = Game.new
            board = game.create_board
            player_one = Player.new("Will", "wht")
            player_two = Player.new("Fernando", "blk")
            square = board["A5"]
            rook = Rook.new("wht")
            rook.set_square(square)
            square.set_piece(rook)
            move = Move.new(player_one)
            move.get_opponent(player_two)
            move.get_square(square)
            move.get_piece(square)
            move.get_board(board)
            game.record_move(move)

            expect(game.moves_history[0].player).to eql(player_one)
        end

        it "allows the opponent in a move to be accessed" do
            game = Game.new
            board = game.create_board
            player_one = Player.new("Will", "wht")
            player_two = Player.new("Fernando", "blk")
            square = board["A5"]
            rook = Rook.new("wht")
            rook.set_square(square)
            square.set_piece(rook)
            move = Move.new(player_one)
            move.get_opponent(player_two)
            move.get_square(square)
            move.get_piece(square)
            move.get_board(board)
            game.record_move(move)

            expect(game.moves_history[0].opponent).to eql(player_two)
        end

        it "allows the piece moved in a move to be accessed" do
            game = Game.new
            board = game.create_board
            player_one = Player.new("Will", "wht")
            player_two = Player.new("Fernando", "blk")
            square = board["A5"]
            rook = Rook.new("wht")
            rook.set_square(square)
            square.set_piece(rook)
            move = Move.new(player_one)
            move.get_opponent(player_two)
            move.get_square(square)
            move.get_piece(square)
            move.get_board(board)
            game.record_move(move)

            expect(game.moves_history[0].piece).to eql(rook)
        end

        it "allows the square a piece was moved to in a move to be accessed" do
            game = Game.new
            board = game.create_board
            player_one = Player.new("Will", "wht")
            player_two = Player.new("Fernando", "blk")
            square = board["A5"]
            rook = Rook.new("wht")
            rook.set_square(square)
            square.set_piece(rook)
            move = Move.new(player_one)
            move.get_opponent(player_two)
            move.get_square(square)
            move.get_piece(square)
            move.get_board(board)
            game.record_move(move)

            expect(game.moves_history[0].square).to eql(square)
        end

        it "saves the board state at the end of the move" do
            game = Game.new
            board = game.create_board
            player_one = Player.new("Will", "wht")
            player_two = Player.new("Fernando", "blk")
            square = board["A5"]
            rook = Rook.new("wht")
            rook.set_square(square)
            square.set_piece(rook)
            move = Move.new(player_one)
            move.get_opponent(player_two)
            move.get_square(square)
            move.get_piece(square)
            move.get_board(board)
            game.record_move(move)

            expect(game.moves_history[0].board).to eql(board)
        end
    end


    describe "#valid_coordinate?" do
        it "returns false if more than two characters are entered" do
            input = "A55"
            game = Game.new()
            expect(game.valid_coordinate?(input)).to eql(false)
        end

        it "returns false if input not a valid coordinate but right length" do
            input = "J9"
            game = Game.new()
            expect(game.valid_coordinate?(input)).to eql(false)
        end

        it "returns true for a valid coordinate" do
            input = "D5"
            game = Game.new()
            expect(game.valid_coordinate?(input)).to eql(true)
        end

    end

end