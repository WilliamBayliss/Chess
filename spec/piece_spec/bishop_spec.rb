require './lib/pieces/bishop.rb'

describe Bishop do
    describe "#initialize" do
        it "initializes" do
            bishop = Bishop.new(0)
            expect(bishop).to_not eql(nil)
        end

        it "initializes with a name value of 'Bishop' " do
            bishop = Bishop.new(0)
            expect(bishop.name).to eql("Bishop")
        end

        it "initializes with a square value of nil" do
            bishop = Bishop.new(0)
            expect(bishop.square).to eql(nil)
        end

        it "initializes with the correct wht symbol" do
            bishop = Bishop.new(0)
            expect(bishop.symbol).to eql("♗")
        end

        it "initializes with the correct blk symbol" do
            bishop = Bishop.new(1)
            expect(bishop.symbol).to eql("♝")
        end
    end
end