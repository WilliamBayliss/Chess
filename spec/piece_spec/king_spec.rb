require './lib/pieces/king.rb'

describe King do
    describe "#initialize" do
        it "initializes" do
            king = King.new(0)
            expect(king).to_not eql(nil)
        end

        it "initializes with 'King' name value" do
            king = King.new(0)
            expect(king.name).to eql("King")
        end

        it "initializes with a square of nil" do
            king = King.new(0)
            expect(king.square).to eql(nil)
        end


        it "initializes with the correct wht symbol" do
            king = King.new(0)
            expect(king.symbol).to eql("♔")
        end

        it "initializes with the correct blk symbol" do
            king = King.new(1)
            expect(king.symbol).to eql("♚")
        end
    end
end