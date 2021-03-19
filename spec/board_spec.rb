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


end