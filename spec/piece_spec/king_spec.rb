require '../lib//pieces/king.rb'

describe King do
    describe "#initialize" do
        it "initializes" do
            king = King.new("blk")
            expect(king).to_not eql(nil)
        end

        it "initializes with a square of nil" do
            king = King.new("wht")
            expect(king.square).to eql(nil)
        end


        it "initializes with the correct wht symbol" do
            rook = King.new("wht")
            expect(rook.symbol).to eql("♔")
        end

        it "initializes with the correct blk symbol" do
            rook = King.new("blk")
            expect(rook.symbol).to eql("♚")
        end
    end
end