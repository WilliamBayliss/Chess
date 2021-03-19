require '../lib/piece.rb'

describe Piece do
    describe "#initialize" do
        it "initializes" do
            square = Square.new([[0,0], "A1"])
            piece = Piece.new(square)
            expect(piece).to_not eql(nil)
        end

        it "initializes with a square value" do
            square = Square.new([[0,0], "A1"])
            piece = Piece.new(square)
            expect(piece.square).to eql(square)
        end
    end
    
    describe "#move" do
        it "updates the square value" do
            square = Square.new([[0,0], "A1"])
            piece = Piece.new(square)
            
            new_square = Square.new([[0,5], "F1"])
            piece.move(new_square)
            expect(piece.square).to eql(new_square)
        end
    end

    describe "#diagonal?" do
        it "returns false if nil square" do
            square = Square.new([[0,0], "A1"])
            other_square = nil
            piece = Piece.new(square)
            expect(piece.diagonal?(other_square)).to eql(false)
        end
        
        it "returns false if a square is not in a diagonal like from @square" do
            square = Square.new([[0,0], "A1"])
            other_square = Square.new([[0, 3], "C1"])
            piece = Piece.new(square)
            expect(piece.diagonal?(other_square)).to eql(false)
        
        end

        it "returns true if square is above left" do
            square = Square.new([[3,3], "C4"])
            piece = Piece.new(square)
            other_square = Square.new([[2,2], "B3"])

            expect(piece.diagonal?(other_square)).to eql(true)
        end

        it "returns true if square is above right" do
            square = Square.new([[3,3], "C4"])
            piece = Piece.new(square)
            other_square = Square.new([[2,4], "D3"])
            expect(piece.diagonal?(other_square)).to eql(true)
        end

        it "returns true if square is below left" do
            square = Square.new([[3,3], "C4"])
            piece = Piece.new(square)
            other_square = Square.new([[4,2], "B5"])
            expect(piece.diagonal?(other_square)).to eql(true)
        end

        it "returns true if square is below right" do
            square = Square.new([[3,3], "C4"])
            piece = Piece.new(square)
            other_square = Square.new([[4,4], "D5"])
            expect(piece.diagonal?(other_square)).to eql(true)
        end
    end
end