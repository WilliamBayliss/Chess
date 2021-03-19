require './lib/board.rb'

describe Board do
    describe "#initialize" do
        it "initializes" do
            board = Board.new
            expect(board).to_not eql(nil)
        end
    end

    describe '#[]' do
        it "retreives a square on the board with a given coordinate" do
            board = Board.new
            square = Square.new([0,0, "A1"])
            board.add_square(square)
            expect(board[square.name]).to eql(square)
        end
    end

    describe "#add_square" do
        it "adds a square to the board" do
            board = Board.new
            square = Square.new([0,0, "A1"])
            board.add_square(square)
            expect(board[square.name]).to eql(square)
        end
    end

    describe "#board_array" do
        it "returns the array" do
            board = Board.new
            expect(board.board_array).to eql(
                [
                    [[1,1], "A1"], [[1,2], "B1"], [[1,3], "C1"], [[1,4], "D1"], [[1,5], "E1"], [[1,6], "F1"], [[1,7], "G1"], [[1,8], "H1"], 
                    [[2,1], "A2"], [[2,2], "B2"], [[2,3], "C2"], [[2,4], "D2"], [[2,5], "E2"], [[2,6], "F2"], [[2,7], "G2"], [[2,8], "H2"], 
                    [[3,1], "A3"], [[3,2], "B3"], [[3,3], "C3"], [[3,4], "D3"], [[3,5], "E3"], [[3,6], "F3"], [[3,7], "G3"], [[3,8], "H3"], 
                    [[4,1], "A4"], [[4,2], "B4"], [[4,3], "C4"], [[4,4], "D4"], [[4,5], "E4"], [[4,6], "F4"], [[4,7], "G4"], [[4,8], "H4"], 
                    [[5,1], "A5"], [[5,2], "B5"], [[5,3], "C5"], [[5,4], "D5"], [[5,5], "E5"], [[5,6], "F5"], [[5,7], "G5"], [[5,8], "H5"], 
                    [[6,1], "A6"], [[6,2], "B6"], [[6,3], "C6"], [[6,4], "D6"], [[6,5], "E6"], [[6,6], "F6"], [[6,7], "G6"], [[6,8], "H6"], 
                    [[7,1], "A7"], [[7,2], "B7"], [[7,3], "C7"], [[7,4], "D7"], [[7,5], "E7"], [[7,6], "F7"], [[7,7], "G7"], [[7,8], "H7"], 
                    [[8,1], "A8"], [[8,2], "B8"], [[8,3], "C8"], [[8,4], "D8"], [[8,5], "E8"], [[8,6], "F8"], [[8,7], "G8"], [[8,8], "H8"], 
                ]
            )
        end
    end

    describe "#create_board" do
        it "adds squares to the board" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board["A1"]).to_not eql(nil)
        end

        it "adds squares with correct coordinates" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board["B5"].coordinate).to eql([5,2])
        end

        it "adds squares with correct names" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board["C8"].name).to eql("C8")
        end
    end

    describe "#diagonal?" do
        it "returns false if either square is nil" do
            board = Board.new
            board.create_board(board.board_array)
            square_one = nil
            square_two = board["A1"]
            expect(board.diagonal?(
                square_one, 
                square_two
                )).to eql(false)
        end

        it "returns false if the two squares are on the same row" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["A1"],
                board["B1"]
            )).to eql(false)
        end

        it "returns false if the two squares are vertically aligned" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["A1"],
                board["A1"]
            )).to eql(false)
        end

        it "returns false if the squares are not diagonal" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["A1"],
                board["D3"]
            )).to eql(false)
        end

        it "returns true if square is above right" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["D5"],
                board["F3"]
            )).to eql(true)
        end

        it "returns true if square is below right" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["D5"],
                board["F7"]
            )).to eql(true)
        end

        it "returns true if square is below left" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["D5"],
                board["B7"]
            )).to eql(true)
        end

        it "returns true if square is above left" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["D5"],
                board["A2"]
            )).to eql(true)
        end
    end

    describe "#vertical" do
        it "returns false if either square is nil" do
            board = Board.new
            square_one = nil
            square_two = Square.new([[0,0], "A1"])
            expect(board.vertical?(
                square_one, 
                square_two
                )).to eql(false)
        end

        it "returns false if squares are on same row" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.vertical?(
                board["D5"],
                board["E5"]
            )).to eql(false)
        end

        it "returns false if squares are diagonal" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.vertical?(
                board["B3"],
                board["A2"]
            )).to eql(false)
        end

        it "returns false if squares are not vertical" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.vertical?(
                board["D5"],
                board["F8"]
            )).to eql(false)
        end

        it "returns true if squares are vertical" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.vertical?(
                board["D5"],
                board["D3"]
            )).to eql(true)
        end
    end

    describe "#horizontal" do
        it "returns false if either square is nil" do
            board = Board.new
            square_one = nil
            square_two = Square.new([[0,0], "A1"])
            expect(board.horizontal?(
                square_one, 
                square_two
                )).to eql(false)
        end

        it "returns false if squares are vertically aligned" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.horizontal?(
                board["D5"],
                board["D3"]
            )).to eql(false)
        end

        it "returns false if squares are diagonal" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.horizontal?(
                board["B3"],
                board["A2"]
            )).to eql(false)
        end

        it "returns false if squares are not horizontal" do

            board = Board.new
            board.create_board(board.board_array)
            expect(board.horizontal?(
                board["D5"],
                board["F8"]
            )).to eql(false)
        end

        it "returns true if squares are horizontal" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.horizontal?(
                board["D5"],
                board["E5"]
            )).to eql(true)
        end
    end

    describe "#knight_move?" do
        it "returns false if square is nil" do
            board = Board.new
            board.create_board(board.board_array)
            square = board["A1"]
            other_square = nil
            expect(board.knight_move?(square, other_square)).to eql(false)
        end
        it "returns false if move illegal" do
            board = Board.new
            board.create_board(board.board_array)
            square = board["A1"]
            other_square = board["B2"]
            expect(board.knight_move?(square, other_square)).to eql(false)
        end

        it "returns true if move legal" do
            board = Board.new
            board.create_board(board.board_array)
            square = board["A1"]
            other_square = board["C2"]
            expect(board.knight_move?(square, other_square)).to eql(true)
        end
    end
end