require './lib/pieces/pawn.rb'

describe Pawn do
    describe "#initialize" do
        it "initializes" do
            pawn = Pawn.new(0)
            expect(pawn).to_not eql(nil)
        end

        it "initializes with a name of 'Pawn' " do
            pawn = Pawn.new(0)
            expect(pawn.name).to eql("Pawn")
        end

        it "initializes with a square value of nil" do
            pawn = Pawn.new(0)
            expect(pawn.square).to eql(nil)
        end

        it "initializes with the correct wht symbol" do
            pawn = Pawn.new(0)
            expect(pawn.symbol).to eql("♙")
        end

        it "initializes with the correct blk symbol" do
            pawn = Pawn.new(1)
            expect(pawn.symbol).to eql("♟︎")
        end

        it "initializes with a moved value of false" do
            pawn = Pawn.new(1)
            expect(pawn.moved).to eql(false)
        end
    end


end