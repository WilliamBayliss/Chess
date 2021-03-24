require '../lib/pieces/bishop.rb'

describe Bishop do
    describe "#initialize" do
        it "initializes" do
            bishop = Bishop.new("wht")
            expect(bishop).to_not eql(nil)
        end

        it "initializes with a square value of nil" do
            bishop = Bishop.new("wht")
            expect(bishop.square).to eql(nil)
        end

        it "initializes with the correct wht symbol" do
            bishop = Bishop.new("wht")
            expect(bishop.symbol).to eql("♗")
        end

        it "initializes with the correct blk symbol" do
            bishop = Bishop.new("blk")
            expect(bishop.symbol).to eql("♝")
        end
    end
end