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
end