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
    end
end