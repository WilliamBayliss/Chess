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

    describe "#legal_move" do
        it "returns false if move illegal" do
            square = Square.new([[0,0], "A1"])
            knight = Knight.new(square)
            square_two = Square.new([[0,1], "B1"])
            expect(knight.legal_move?(square_two)).to eql(false)
        end

        it "returns true if move legal" do
            square = Square.new([[0,0], "A1"])
            knight = Knight.new(square)
            square_two = Square.new([[1,2], "C1"])
            expect(knight.legal_move?(square_two)).to eql(true)
        end
    end
end