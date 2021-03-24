require '../lib/pieces/queen.rb'

describe Queen do
    describe "#initialize" do
        it "initializes" do
            queen = Queen.new("wht")
            expect(queen).to_not eql(nil)
        end

        it "initializes with a square of nil" do
            queen = Queen.new("wht")
            expect(queen.square).to eql(nil)
        end

        it "initializes with the correct wht symbol" do
            queen = Queen.new("wht")
            expect(queen.symbol).to eql("♕")
        end

        it "initializes with the correct blk symbol" do
            queen = Queen.new("blk")
            expect(queen.symbol).to eql("♛")
        end
    end
end