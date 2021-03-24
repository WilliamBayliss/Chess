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
end