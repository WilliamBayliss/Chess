require '../lib//pieces/king.rb'

describe King do
    describe "#initialize" do
        it "initializes" do
            square = [[0,0], "A1"]
            king = King.new(square)
            expect(king).to_not eql(nil)
        end

        it "initializes with a square" do
            square = [[0,0], "A1"]
            king = King.new(square)
            expect(king.square).to eql(square)
        end
    end
end