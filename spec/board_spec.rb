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
                    [[0,1], "A1"], [[0,2], "B1"], [[0,3], "C1"], [[0,4], "D1"], [[0,5], "E1"], [[0,6], "F1"], [[0,7], "G1"], [[0,8], "H1"], 
                    [[1,1], "A2"], [[1,2], "B2"], [[1,3], "C2"], [[1,4], "D2"], [[1,5], "E2"], [[1,6], "F2"], [[1,7], "G2"], [[1,8], "H2"], 
                    [[2,1], "A3"], [[2,2], "B3"], [[2,3], "C3"], [[2,4], "D3"], [[2,5], "E3"], [[2,6], "F3"], [[2,7], "G3"], [[2,8], "H3"], 
                    [[3,1], "A4"], [[3,2], "B4"], [[3,3], "C4"], [[3,4], "D4"], [[3,5], "E4"], [[3,6], "F4"], [[3,7], "G4"], [[3,8], "H4"], 
                    [[4,1], "A5"], [[4,2], "B5"], [[4,3], "C5"], [[4,4], "D5"], [[4,5], "E5"], [[4,6], "F5"], [[4,7], "G5"], [[4,8], "H5"], 
                    [[5,1], "A6"], [[5,2], "B6"], [[5,3], "C6"], [[5,4], "D6"], [[5,5], "E6"], [[5,6], "F6"], [[5,7], "G6"], [[5,8], "H6"], 
                    [[6,1], "A7"], [[6,2], "B7"], [[6,3], "C7"], [[6,4], "D7"], [[6,5], "E7"], [[6,6], "F7"], [[6,7], "G7"], [[6,8], "H7"], 
                    [[7,1], "A8"], [[7,2], "B8"], [[7,3], "C8"], [[7,4], "D8"], [[7,5], "E8"], [[7,6], "F8"], [[7,7], "G8"], [[7,8], "H8"], 
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
            expect(board["B5"].coordinate).to eql([4,2])
        end

        it "adds squares with correct names" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board["C8"].name).to eql("C8")
        end
    end

end