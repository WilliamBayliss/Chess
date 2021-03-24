require './lib/pieces/rook.rb'

describe Rook do
    describe "#initialize" do
        it "initializes" do
            rook = Rook.new("wht")
            expect(rook).to_not eql(nil)
        end

        it "initializes with a square of nil" do
            rook = Rook.new("wht")
            expect(rook.square).to eql(nil)
        end

        it "initializes with the correct wht symbol" do
            rook = Rook.new("wht")
            expect(rook.symbol).to eql("♖")
        end

        it "initializes with the correct blk symbol" do
            rook = Rook.new("blk")
            expect(rook.symbol).to eql("♜")
        end
    end
end