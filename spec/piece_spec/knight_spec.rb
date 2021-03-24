require "../lib/pieces/knight.rb"

describe Knight do
    describe "#initialize" do
        it "initializes" do
            knight = Knight.new("wht")
            expect(knight).to_not eql(nil)
        end

        it "initializes with a square value of nil" do
            knight = Knight.new("wht")
            expect(knight.square).to eql(nil)
        end
    end
end