require '../lib/pieces/bishop.rb'

describe Bishop do
    describe "#initialize" do
        it "initializes" do
            square = Square.new([[0,0], "A1"])
            bishop = Bishop.new(square)
            expect(bishop).to_not eql(nil)
        end

        it "initializes with a square" do
            square = Square.new([[0,0], "A1"])
            bishop = Bishop.new(square)
            expect(bishop.square).to eql(square)
        end
    end
end