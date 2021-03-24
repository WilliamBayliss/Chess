require './lib/board/square.rb'

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

        it "initializes symbol value to empty space" do
            square = Square.new([[0,0], "A1"])
            expect(square.symbol).to eql(" ")
        end

        it "initializes piece value to nil" do
            square = Square.new([[0,0], "A1"])
            expect(square.piece).to eql(nil)
        end
    end

    describe "#set_piece" do
        it "updates the square's piece value" do
            square = Square.new([[0,0], "A1"])
            pawn = Pawn.new("blk")
            square.set_piece(pawn)
            expect(square.piece).to eql(pawn)
        end

        it "updates the square's symbol value" do
            square = Square.new([[0,0], "A1"])
            pawn = Pawn.new("blk")
            square.set_piece(pawn)
            expect(square.symbol).to eql("♟︎")
        end
    end

end