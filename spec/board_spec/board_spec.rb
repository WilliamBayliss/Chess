require './lib/board/board.rb'

describe Board do
    describe "#initialize" do
        it "initializes" do
            board = Board.new
            expect(board).to_not eql(nil)
        end
    end

    describe '#[]' do
        it "retreives a square on the board with a given coordinate" do
            board = Board.new
            square = Square.new([0,0, "A1"])
            board.add_square(square)
            expect(board[square.name]).to eql(square)
        end
    end

    describe "#add_square" do
        it "adds a square to the board" do
            board = Board.new
            square = Square.new([0,0, "A1"])
            board.add_square(square)
            expect(board[square.name]).to eql(square)
        end
    end

    describe "#board_array" do
        it "returns the array" do
            board = Board.new
            expect(board.board_array).to eql(
                [
                    [[1,1], "A1"], [[1,2], "B1"], [[1,3], "C1"], [[1,4], "D1"], [[1,5], "E1"], [[1,6], "F1"], [[1,7], "G1"], [[1,8], "H1"], 
                    [[2,1], "A2"], [[2,2], "B2"], [[2,3], "C2"], [[2,4], "D2"], [[2,5], "E2"], [[2,6], "F2"], [[2,7], "G2"], [[2,8], "H2"], 
                    [[3,1], "A3"], [[3,2], "B3"], [[3,3], "C3"], [[3,4], "D3"], [[3,5], "E3"], [[3,6], "F3"], [[3,7], "G3"], [[3,8], "H3"], 
                    [[4,1], "A4"], [[4,2], "B4"], [[4,3], "C4"], [[4,4], "D4"], [[4,5], "E4"], [[4,6], "F4"], [[4,7], "G4"], [[4,8], "H4"], 
                    [[5,1], "A5"], [[5,2], "B5"], [[5,3], "C5"], [[5,4], "D5"], [[5,5], "E5"], [[5,6], "F5"], [[5,7], "G5"], [[5,8], "H5"], 
                    [[6,1], "A6"], [[6,2], "B6"], [[6,3], "C6"], [[6,4], "D6"], [[6,5], "E6"], [[6,6], "F6"], [[6,7], "G6"], [[6,8], "H6"], 
                    [[7,1], "A7"], [[7,2], "B7"], [[7,3], "C7"], [[7,4], "D7"], [[7,5], "E7"], [[7,6], "F7"], [[7,7], "G7"], [[7,8], "H7"], 
                    [[8,1], "A8"], [[8,2], "B8"], [[8,3], "C8"], [[8,4], "D8"], [[8,5], "E8"], [[8,6], "F8"], [[8,7], "G8"], [[8,8], "H8"], 
                ]
            )
        end
    end

    describe "#create_board" do
        it "adds squares to the board" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board["A1"]).to_not eql(nil)
        end

        it "adds squares with correct coordinates" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board["B5"].coordinate).to eql([5,2])
        end

        it "adds squares with correct names" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board["C8"].name).to eql("C8")
        end
    end

    describe "#move_piece" do
        it "returns false if a move is illegal" do
            board = Board.new
            board.create_board(board.board_array)

            rook = Rook.new("wht")
            rook.set_square(board["A1"])

            
            expect(board.move_piece(
                rook, 
                board["B5"]
                )).to eql(false)
        end
        it "returns true if a move is legal" do
            board = Board.new
            board.create_board(board.board_array)

            rook = Rook.new("wht")
            rook.set_square(board["A1"])

            
            expect(board.move_piece(
                rook, 
                board["G1"]
                )).to eql(true)
        end
        it "sets the piece's square value" do
            board = Board.new
            board.create_board(board.board_array)

            rook = Rook.new("wht")
            rook.set_square(board["A1"])

            board.move_piece(rook, board["A5"])
            expect(rook.square).to eql(board["A5"])
        end

        it "sets the square's piece value" do
            board = Board.new
            board.create_board(board.board_array)

            rook = Rook.new("wht")
            rook.set_square(board["A1"])

            board.move_piece(rook, board["A5"])
            expect(board["A5"].piece).to eql(rook)
        end

        it "resets the piece value of the square the piece moved from to nil" do
            board = Board.new
            board.create_board(board.board_array)

            rook = Rook.new("wht")
            rook.set_square(board["A1"])

            board.move_piece(rook, board["A5"])
            expect(board["A1"].piece).to eql(nil)
        end

        it "resets the symbol value of the square the piece moved from to empty space" do    
            board = Board.new
            board.create_board(board.board_array)

            rook = Rook.new("wht")
            rook.set_square(board["A1"])

            board.move_piece(rook, board["A5"])
            expect(board["A1"].symbol).to eql(" ")
        end
    end

    describe "#diagonal?" do
        it "returns false if either square is nil" do
            board = Board.new
            board.create_board(board.board_array)
            square_one = nil
            square_two = board["A1"]
            expect(board.diagonal?(
                square_one, 
                square_two
                )).to eql(false)
        end

        it "returns false if the two squares are on the same row" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["A1"],
                board["B1"]
            )).to eql(false)
        end

        it "returns false if the two squares are vertically aligned" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["A1"],
                board["A1"]
            )).to eql(false)
        end

        it "returns false if the squares are not diagonal" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["A1"],
                board["D3"]
            )).to eql(false)
        end

        it "returns true if square is above right" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["D5"],
                board["F3"]
            )).to eql(true)
        end

        it "returns true if square is below right" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["D5"],
                board["F7"]
            )).to eql(true)
        end

        it "returns true if square is below left" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["D5"],
                board["B7"]
            )).to eql(true)
        end

        it "returns true if square is above left" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["D5"],
                board["A2"]
            )).to eql(true)
        end
    end

    describe "#vertical" do
        it "returns false if either square is nil" do
            board = Board.new
            square_one = nil
            square_two = Square.new([[0,0], "A1"])
            expect(board.vertical?(
                square_one, 
                square_two
                )).to eql(false)
        end

        it "returns false if squares are on same row" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.vertical?(
                board["D5"],
                board["E5"]
            )).to eql(false)
        end

        it "returns false if squares are diagonal" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.vertical?(
                board["B3"],
                board["A2"]
            )).to eql(false)
        end

        it "returns false if squares are not vertical" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.vertical?(
                board["D5"],
                board["F8"]
            )).to eql(false)
        end

        it "returns true if squares are vertical" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.vertical?(
                board["D5"],
                board["D3"]
            )).to eql(true)
        end
    end

    describe "#horizontal" do
        it "returns false if either square is nil" do
            board = Board.new
            square_one = nil
            square_two = Square.new([[0,0], "A1"])
            expect(board.horizontal?(
                square_one, 
                square_two
                )).to eql(false)
        end

        it "returns false if squares are vertically aligned" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.horizontal?(
                board["D5"],
                board["D3"]
            )).to eql(false)
        end

        it "returns false if squares are diagonal" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.horizontal?(
                board["B3"],
                board["A2"]
            )).to eql(false)
        end

        it "returns false if squares are not horizontal" do

            board = Board.new
            board.create_board(board.board_array)
            expect(board.horizontal?(
                board["D5"],
                board["F8"]
            )).to eql(false)
        end

        it "returns true if squares are horizontal" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.horizontal?(
                board["D5"],
                board["E5"]
            )).to eql(true)
        end
    end

    describe "#adjacent?" do
        it "returns false if squares are nil" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.adjacent?(
                nil,
                nil
            )).to eql(false)
        end

        it "returns false if squares are not adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.adjacent?(
                board["B3"],
                board["D2"]
            )).to eql(false)
        end

        it "returns true if squares are horizontally adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.adjacent?(
                board["B2"],
                board["C2"]
            )).to eql(true)
        end


        it "returns true if squares are horizontally adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.adjacent?(
                board["B2"],
                board["B1"]
            )).to eql(true)
        end

        it "returns true if squares are vertically adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.adjacent?(
                board["D5"],
                board["D6"]
            )).to eql(true)
        end

        it "returns true if squares are vertically adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.adjacent?(
                board["D5"],
                board["D4"]
            )).to eql(true)
        end

        it "returns true if squares are diagonally adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.adjacent?(
                board["D5"],
                board["E6"]
            )).to eql(true)
        end


        it "returns true if squares are diagonally adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.adjacent?(
                board["D5"],
                board["C6"]
            )).to eql(true)
        end


        it "returns true if squares are diagonally adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.adjacent?(
                board["D5"],
                board["C4"]
            )).to eql(true)
        end

        it "returns true if squares are diagonally adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.adjacent?(
                board["D5"],
                board["E4"]
            )).to eql(true)
        end
    end

    describe "#knight_move?" do
        it "returns false if square is nil" do
            board = Board.new
            board.create_board(board.board_array)
            square = board["A1"]
            other_square = nil
            expect(board.knight_move?(
                square,
                other_square
                )).to eql(false)
        end
        it "returns false if move illegal" do
            board = Board.new
            board.create_board(board.board_array)
            square = board["A1"]
            other_square = board["B2"]
            expect(board.knight_move?(
                square, 
                other_square
                )).to eql(false)
        end

        it "returns true if move legal" do
            board = Board.new
            board.create_board(board.board_array)
            square = board["A1"]
            other_square = board["C2"]
            expect(board.knight_move?(
                square, 
                other_square
                )).to eql(true)
        end
    end

    describe "#rook_move?" do
        it "returns false if a square is neither vertically or horizontally accessible from start square" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.rook_move?(
                board["A1"], 
                board["B2"]
                )).to eql(false)

        end

        it "returns true if a square is vertically accessible" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.rook_move?(
                board["A1"], 
                board["A5"]
                )).to eql(true)
        end

        it "returns true if a square is horizontally accessible" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.rook_move?(
                board["A3"], 
                board["D3"]
                )).to eql(true)
        end
    end

    describe "#queen_move?" do
        it "returns false if a square is not in a straight line from start square" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.queen_move?(
                board["A1"], 
                board["B7"]
                )).to eql(false)
        end

        it "returns true if a square is horizontal" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.queen_move?(
                board["D5"], 
                board["A5"]
                )).to eql(true)
        end

        it "returns true if a square is vertical" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.queen_move?(
                board["A1"], 
                board["A5"]
                )).to eql(true)
        end

        it "returns true if a square is diagonal" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.queen_move?(
                board["A4"], 
                board["B3"]
                )).to eql(true)
        end
    end

    describe "#bishop_move?" do
        it "returns false if a square is not diagonally accessible from start square" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.bishop_move?(
                board["A1"], 
                board["A2"]
                )).to eql(false)
        end

        it "returns true if a square is diagonally accessible from start square" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.bishop_move?(
                board["A4"], 
                board["B3"]
                )).to eql(true)
        end
    end

    describe "#king_move?" do
        it "returns false if square is not adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.king_move?(
                board["A4"], 
                board["D3"]
                )).to eql(false)
        end

        it "returns false if square is not adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.king_move?(
                board["A4"], 
                board["A6"]
                )).to eql(false)
        end

        it "returns true if square is adjacent in any direction" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.king_move?(
                board["B4"], 
                board["B3"]
                )).to eql(true)
        end

        it "returns true if square is adjacent in any direction" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.king_move?(
                board["B4"], 
                board["C3"]
                )).to eql(true)
        end

        it "returns true if square is adjacent in any direction" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.king_move?(
                board["B4"], 
                board["C4"]
                )).to eql(true)
        end

        it "returns true if square is adjacent in any direction" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.king_move?(
                board["B4"], 
                board["C5"]
                )).to eql(true)
        end

        it "returns true if square is adjacent in any direction" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.king_move?(
                board["B4"], 
                board["B5"]
                )).to eql(true)
        end

        it "returns true if square is adjacent in any direction" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.king_move?(
                board["B4"], 
                board["A5"]
                )).to eql(true)
        end


        it "returns true if square is adjacent in any direction" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.king_move?(
                board["B4"], 
                board["A4"]
                )).to eql(true)
        end


        it "returns true if square is adjacent in any direction" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.king_move?(
                board["B4"], 
                board["A3"]
                )).to eql(true)
        end
    end

    describe "#pawn_move" do
        it "returns false if a square is neither vertical nor adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("wht")
            expect(board.pawn_move?(
                pawn,
                board["B4"], 
                board["A3"]
                )).to eql(false)
        end 

        it "returns true if a square is vertical and adjacent, and a correct move for a white pawn" do

            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("wht")
            expect(board.pawn_move?(
                pawn,
                board["A5"], 
                board["A6"]
                )).to eql(true)
        end

        it "returns false if a square is vertical and adjacent, but an illegal move for a white pawn" do

            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("wht")
            expect(board.pawn_move?(
                pawn,
                board["A5"], 
                board["A4"]
                )).to eql(false)
        end


        it "returns true if a square is vertical and adjacent, and a correct move for a black pawn" do

            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("blk")
            expect(board.pawn_move?(
                pawn,
                board["A3"], 
                board["A2"]
                )).to eql(true)
        end

        it "returns false if a square is vertical and adjacent, but an illegal move for a black pawn" do

            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("blk")
            expect(board.pawn_move?(
                pawn,
                board["A2"], 
                board["A3"]
                )).to eql(false)
        end
    end

    describe "#legal_move?" do
        it "returns false for an illegal pawn move" do
            board = Board.new
            board.create_board(board.board_array)

            pawn = Pawn.new("wht")
            pawn.set_square(board["A5"])
            expect(board.legal_move?(
                pawn,
                board["B4"]
            )).to eql(false)
        end

        it "returns true for a legal white pawn move" do
            board = Board.new
            board.create_board(board.board_array)

            pawn = Pawn.new("wht")
            pawn.set_square(board["A5"])
            expect(board.legal_move?(
                pawn,
                board["A6"]
            )).to eql(true)
        end

        it "returns true for a legal black pawn move" do
            board = Board.new
            board.create_board(board.board_array)

            pawn = Pawn.new("blk")
            pawn.set_square(board["A5"])
            expect(board.legal_move?(
                pawn,
                board["A4"]
            )).to eql(true)
        end

        it "returns false for an illegal knight move" do
            board = Board.new
            board.create_board(board.board_array)

            piece = Knight.new("wht")
            piece.set_square(board["A5"])
            expect(board.legal_move?(
                piece,
                board["A6"]
            )).to eql(false)
        end

        it "returns true for a legal knight move" do
            board = Board.new
            board.create_board(board.board_array)

            piece = Knight.new("wht")
            piece.set_square(board["A5"])
            expect(board.legal_move?(
                piece,
                board["C4"]
            )).to eql(true)
        end

        it "returns false for an illegal bishop move" do
            board = Board.new
            board.create_board(board.board_array)

            piece = Bishop.new("wht")
            piece.set_square(board["A5"])
            expect(board.legal_move?(
                piece,
                board["D5"]
            )).to eql(false)
        end

        it "returns true for a legal bishop move" do
            board = Board.new
            board.create_board(board.board_array)

            piece = Bishop.new("wht")
            piece.set_square(board["D1"])
            expect(board.legal_move?(
                piece,
                board["A4"]
            )).to eql(true)
        end

        it "returns false for an illegal rook move" do            
            board = Board.new
            board.create_board(board.board_array)

            piece = Rook.new("wht")
            piece.set_square(board["A5"])
            expect(board.legal_move?(
                piece,
                board["D6"]
            )).to eql(false)

        end

        it "returns true for a legal rook move" do
            board = Board.new
            board.create_board(board.board_array)

            piece = Rook.new("wht")
            piece.set_square(board["A5"])
            expect(board.legal_move?(
                piece,
                board["A7"]
            )).to eql(true)
        end

        it "returns false for an illegal queen move" do
            board = Board.new
            board.create_board(board.board_array)

            piece = Queen.new("wht")
            piece.set_square(board["A5"])
            expect(board.legal_move?(
                piece,
                board["D7"]
            )).to eql(false)
        end

        it "returns true for a legal queen move" do
            board = Board.new
            board.create_board(board.board_array)

            piece = Queen.new("wht")
            piece.set_square(board["A5"])
            expect(board.legal_move?(
                piece,
                board["C3"]
            )).to eql(true)
        end

        it "returns false for an illegal king move" do
            board = Board.new
            board.create_board(board.board_array)

            piece = King.new("wht")
            piece.set_square(board["A5"])
            expect(board.legal_move?(
                piece,
                board["A7"]
            )).to eql(false)
        end

        it "returne true for a legal king move" do
            board = Board.new
            board.create_board(board.board_array)

            piece = King.new("wht")
            piece.set_square(board["A5"])
            expect(board.legal_move?(
                piece,
                board["A6"]
            )).to eql(true)
        end
    end

end