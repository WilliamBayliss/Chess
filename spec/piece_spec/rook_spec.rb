require '../lib/pieces/rook.rb'

describe Rook do
    describe "#initialize" do
        it "initializes" do
            square = Square.new([[0,0], "A1"])
            rook = Rook.new(square)
            expect(rook).to_not eql(nil)
        end

        it "initializes with a square" do
            square = Square.new([[0,0], "A1"])
            rook = Rook.new(square)
            expect(rook.square).to eql(square)
        end
    end

    describe "#legal_move?" do
        it "returns false if square does not exist" do
            square = Square.new([[0,0], "A1"])
            rook = Rook.new(square)
            second_square = nil
            expect(rook.legal_move?(second_square)).to eql(false)
            
        end

        it "returns false if a move is illegal" do
            square = Square.new([[0,0], "A1"])
            rook = Rook.new(square)
            second_square = Square.new([[1,1], "B2"])
            expect(rook.legal_move?(second_square)).to eql(false)
        end

        it "returns true if a move is on the same x axis" do
            square = Square.new([[0,0], "A1"])
            rook = Rook.new(square)
            second_square = Square.new([[0,5], "F1"])
            expect(rook.legal_move?(second_square)).to eql(true)
        end

        it "returns true if a move is on the same y axis" do
            square = Square.new([[0,0], "A1"])
            rook = Rook.new(square)
            second_square = Square.new([[5,0], "A6"])
            expect(rook.legal_move?(second_square)).to eql(true)
        end
    end
end