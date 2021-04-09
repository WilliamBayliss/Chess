require '../lib/pieces/piece.rb'

describe Piece do
    describe "#initialize" do
        it "initializes" do
            piece = Piece.new("wht")
            expect(piece).to_not eql(nil)
        end

        it "initializes with a square valueof nil" do
            piece = Piece.new("wht")
            expect(piece.square).to eql(nil)
        end

        it "initializes with a empty space symbol value" do
            piece = Piece.new("wht")
            expect(piece.symbol).to eql(" ")
        end

        it "initializes @moved to false" do
            piece = Piece.new("blk")
            expect(piece.moved).to eql(false)
        end

        it "initializes @available_moves to empty hash" do
            piece = Piece.new("wht")
            expect(piece.available_moves).to eql({})

        end

    end

    describe "#set_symbol" do
        it "sets a piece's symbol" do
            queen = Piece.new("wht")
            queen.set_symbol("♔")
            expect(queen.symbol).to eql("♔")
        end
    end
    
    describe "#set_square" do
        it "updates the piece's square value" do
            piece = Piece.new("wht")
            new_square = Square.new([[0,5], "F1"])
            piece.set_square(new_square)
            expect(piece.square).to eql(new_square)
        end
    end
    
    describe "#set_moved" do
        it "sets the moved attr of a pawn to true" do
            piece = Piece.new("blk")
            piece.set_moved
            expect(piece.moved).to eql(true)
        end
    end

    describe "#get_move" do
        it "adds a square to the list of available moves" do
            square = Square.new([[0,0], "A1"])
            piece = Piece.new("wht")
            piece.get_move(square)
            expect(piece.available_moves[square.name]).to eql(square)
        end
    end 

    describe "#update_move_list" do
        it "updates the @available_moves hash to exclude a key in arg array" do
            piece = Piece.new("wht")
            a1 = Square.new([[0,0], "A1"])
            c1 = Square.new([[0,1], "C1"])        
            d1 = Square.new([[0,2], "D1"])

            piece.get_move(a1)
            piece.get_move(c1)
            piece.get_move(d1)
            
            illegal_moves = []
            illegal_moves.append(d1)
            piece.update_move_list(illegal_moves)
            expect(piece.available_moves).to_not include(d1.name)

        end

        it "deletes all the squares in the given array" do
            piece = Piece.new("wht")
            a1 = Square.new([[0,0], "A1"])
            c1 = Square.new([[0,1], "C1"])        
            d1 = Square.new([[0,2], "D1"])
            e1 = Square.new([[0,3], "E1"])


            piece.get_move(a1)
            piece.get_move(c1)
            piece.get_move(d1)
            
            illegal_moves = []
            illegal_moves.append(c1)
            illegal_moves.append(d1)
            illegal_moves.append(e1)


            piece.update_move_list(illegal_moves)
            expect(piece.available_moves.size).to eql(1)
        end
    
    end
end