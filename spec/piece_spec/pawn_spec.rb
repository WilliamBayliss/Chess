require './lib/pieces/pawn.rb'

describe Pawn do
    describe "#initialize" do
        it "initializes" do
            pawn = Pawn.new("wht")
            expect(pawn).to_not eql(nil)
        end

        it "initializes with a square value of nil" do
            pawn = Pawn.new("wht")
            expect(pawn.square).to eql(nil)
        end

        it "initializes with the correct wht symbol" do
            pawn = Pawn.new("wht")
            expect(pawn.symbol).to eql("♙")
        end

        it "initializes with the correct blk symbol" do
            pawn = Pawn.new("blk")
            expect(pawn.symbol).to eql("♟︎")
        end
    end

end