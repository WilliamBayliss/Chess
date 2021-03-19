require '../lib/pieces/queen.rb'

describe Queen do
    describe "#initialize" do
        it "initializes" do
            square = [[0,0], "A1"]
            queen = Queen.new(square)
            expect(queen).to_not eql(nil)
        end

        it "initializes with a square" do
            square = [[0,0], "A1"]
            queen = Queen.new(square)
            expect(queen.square).to eql(square)
        end
    end
end