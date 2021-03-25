require '../lib/pieces/piece.rb'

describe Piece do
    describe "#initialize" do
        it "initializes" do
            piece = Piece.new("wht")
            expect(piece).to_not eql(nil)
        end

        it "initializes with a square valueof nil" do
            piece = Piece.new("wht")
            expect(piece.square).to eql(nil)
        end

        it "initializes with a empty space symbol value" do
            piece = Piece.new("wht")
            expect(piece.symbol).to eql(" ")
        end
    end

    describe "#set_symbol" do
        it "sets a piece's symbol" do
            queen = Piece.new("wht")
            queen.set_symbol("♔")
            expect(queen.symbol).to eql("♔")
        end
    end
    
    describe "#set_square" do
        it "updates the piece's square value" do
            piece = Piece.new("wht")
            new_square = Square.new([[0,5], "F1"])
            piece.set_square(new_square)
            expect(piece.square).to eql(new_square)
        end
    end
end