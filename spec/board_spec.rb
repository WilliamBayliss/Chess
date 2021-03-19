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
            square = Square.new([0,0])
            board.add_square(square)
            expect(board[square.coordinate]).to eql(square)
        end
    end

    describe "#add_square" do
        it "adds a square to the board" do
            board = Board.new
            square = Square.new([0,0])
            board.add_square(square)
            expect(board[square.coordinate]).to eql(square)
        end
    end

    describe "#board_array" do
        it "returns the array" do
            board = Board.new
            expect(board.board_array).to eql(
                [
                    [0,1], [0,2], [0,3], [0,4], [0,5], [0,6], [0,7], [0,8], 
                    [1,1], [1,2], [1,3], [1,4], [1,5], [1,6], [1,7], [1,8], 
                    [2,1], [2,2], [2,3], [2,4], [2,5], [2,6], [2,7], [2,8], 
                    [3,1], [3,2], [3,3], [3,4], [3,5], [3,6], [3,7], [3,8], 
                    [4,1], [4,2], [4,3], [4,4], [4,5], [4,6], [4,7], [4,8], 
                    [5,1], [5,2], [5,3], [5,4], [5,5], [5,6], [5,7], [5,8], 
                    [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7], [6,8], 
                    [7,1], [7,2], [7,3], [7,4], [7,5], [7,6], [7,7], [7,8], 
                ])
        end
    end

end