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

        it "initializes with a moved value of false" do
            pawn = Pawn.new("blk")
            expect(pawn.moved).to eql(false)
        end
    end

    describe "#set_moved" do
        it "sets the moved attr of a pawn to true" do
            pawn = Pawn.new("blk")
            pawn.set_moved
            expect(pawn.moved).to eql(true)
        end
    end

end