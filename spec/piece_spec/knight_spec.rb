require "../lib/pieces/knight.rb"

describe Knight do
    describe "#initialize" do
        it "initializes" do
            knight = Knight.new([[0,0], "A1"])
            expect(knight).to_not eql(nil)
        end

        it "initializes with a square value" do
            square = Square.new([[0,0], "A1"])
            knight = Knight.new(square)
            expect(knight.square).to eql(square)
        end
    end
end