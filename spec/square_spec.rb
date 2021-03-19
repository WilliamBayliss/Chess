require './lib/square.rb'

describe Square do
    describe "#initialize" do
        it "initializes" do
            square = Square.new([[0,0], "A1"])
            expect(square).to_not eql(nil)
        end

        it "initializes with the given coordinate attr" do
            square = Square.new([[0,0], "A1"])
            expect(square.coordinate).to eql([0,0])
        end

        it "initializes name value to of last item in coordinate" do
            square = Square.new([[0,0], "A1"])
            expect(square.name).to eql("A1")
        end

        it "initializes piece value to nil" do
            square = Square.new([[0,0], "A1"])
            expect(square.piece).to eql(nil)
        end
    end

end