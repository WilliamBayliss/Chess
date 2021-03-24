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

        it "initializes piece value to empty space" do
            square = Square.new([[0,0], "A1"])
            expect(square.piece).to eql(" ")
        end
    end

    describe "#set_piece" do
        it "updates the square's piece value" do
            square = Square.new([[0,0], "A1"])
            square.set_piece("♟︎")
            expect(square.piece).to eql("♟︎")

        end


    end

end