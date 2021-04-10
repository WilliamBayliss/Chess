require './lib/pieces/rook.rb'

describe Rook do
    describe "#initialize" do
        it "initializes" do
            rook = Rook.new(0)
            expect(rook).to_not eql(nil)
        end

        it "initializes with 'Rook' name value" do
            rook = Rook.new(0)
            expect(rook.name).to eql("Rook")
        end

        it "initializes with a square of nil" do
            rook = Rook.new(0)
            expect(rook.square).to eql(nil)
        end

        it "initializes with the correct wht symbol" do
            rook = Rook.new(0)
            expect(rook.symbol).to eql("♖")
        end

        it "initializes with the correct blk symbol" do
            rook = Rook.new(1)
            expect(rook.symbol).to eql("♜")
        end
    end
end