require './lib/board/board.rb'

describe Board do
    describe "#initialize" do
        it "initializes" do
            board = Board.new
            expect(board).to_not eql(nil)
        end

        it "sets @pieces to empty array" do
            board = Board.new
            expect(board.pieces).to eql([])
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

    describe "#add_edge" do
        it "adds a square on the board's neighbour to the square's neighbours list" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edge("A1", "B1")
            expect(board["A1"].neighbours[0]).to eql(board["B1"])
        end
    end

    describe "#save_piece" do
        it "adds a piece to the @pieces array" do
            piece = Piece.new("wht")
            board = Board.new
            board.save_piece([piece])
            expect(board.pieces).to include(piece)
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

    describe "#add_edges" do
        it "doesn't leave a square's neighbours array empty" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            expect(board["A1"].neighbours).to_not eql([])
        end

        it "correctly adds a square's neighbours" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            expect(board["A1"].neighbours).to include(board["B1"])
        end


        it "correctly adds a square's neighbours" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            expect(board["A1"].neighbours).to include(board["A2"])
        end

        it "correctly adds a square's neighbours" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            expect(board["A1"].neighbours).to include(board["B2"])
        end

        it "doesn't add a square that isn't a neighbour" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            expect(board["A1"].neighbours).to_not include(board["C2"]) 
        end
    end

    describe "#update_piece_moves" do
        it "adds the legal moves of its curent position" do
            board = Board.new
            board.setup
            board.move_piece(
                board["A2"].piece,
                board["A4"]
            )
            expect(board["A4"].piece.available_moves).to include(board["A5"].name)
        end
        
        it "removes moves that are no longer legal" do
            board = Board.new
            board.setup
            board.move_piece(
                board["A2"].piece,
                board["A4"]
            )
            expect(board["A4"].piece.available_moves).to_not include(board["A3"].name)
        end

        it "updates the moves of a piece when another is moved" do
            board = Board.new
            board.setup
            board.move_piece(
                board["A2"].piece,
                board["A4"]
            )
            expect(board["A4"].piece.available_moves).to_not include(board["A3"].name)
        end
    end

    describe "#get_piece_moves" do
        it "adds all a piece's legal moves to that piece's available_moves property" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.get_piece_moves
            expect(board["A2"].piece.available_moves.size).to eql(2)
        end

        it "adds squares on the board to the piece's hash of available moves" do
            board = Board.new
            board.setup
            expect(board["A2"].piece.available_moves).to include(board["A3"].name)
        end

        it "doesn't add illegal moves" do
            board = Board.new
            board.setup
            expect(board["A2"].piece.available_moves).to_not include(board["B4"].name)

        end

        it "doesn't add squares that are occupied by your own pieces" do
            board = Board.new
            board.setup
            board.move_piece(board["E2"].piece, board["E4"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["C5"])
            board.move_piece(board["E1"].piece, board["E2"])
            expect(board["C5"].piece.available_moves).to_not include(board["C7"].name)
        end

        it "adds a knight's legal moves correctly - Up 2 left 1" do
            board = Board.new
            board.setup
            expect(board["B8"].piece.available_moves).to include(board["A6"].name)
        end

        it "adds a knight's legal moves correctly - Up 2 right 1" do
            board = Board.new
            board.setup
            expect(board["B8"].piece.available_moves).to include(board["C6"].name)
        end

        it "adds a knight's down 2 right 1 move" do
            board = Board.new
            board.setup
            expect(board["B1"].piece.available_moves).to include(board["C3"].name)
        end

        it "adds a knight's down 2 left 1 move" do
            board = Board.new
            board.setup
            expect(board["B1"].piece.available_moves).to include(board["A3"].name)
        end

        it "does not add attacked squares to a king's moves list" do
            board = Board.new
            board.setup
            board.move_piece(board["E2"].piece, board["E4"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["C5"])
            board.move_piece(board["E1"].piece, board["E2"])
            board.move_piece(board["D8"].piece, board["G5"])
            expect(board["E2"].piece.available_moves).to_not include(board["E3"].name)
        end
    end

    describe "#delete_illegal_moves" do
        it "removes a move that is no longer legal from a piece's available_moves list" do
            board = Board.new
            board.setup
            bishop = Bishop.new("wht")
            board.place_piece(bishop, board["A3"])
            board.delete_illegal_moves
            expect(board["A2"].piece.available_moves).to_not include(board["A3"].name)
        end
    end

    describe "#place_piece" do
        it "sets a piece's square value" do
            board = Board.new
            piece = Piece.new("wht")
            square = Square.new([[0,0], "A1"])
            board.place_piece(piece, square)
            expect(piece.square).to eql(square)
        end

        it "sets a square's piece value" do
            board = Board.new
            piece = Piece.new("wht")
            square = Square.new([[0,0], "A1"])
            board.place_piece(piece, square)
            expect(square.piece).to eql(piece) 
        end

    end

    describe "#castle?" do
        it "returns false if the path between king and rook is not clear" do
            board = Board.new
            board.setup
            expect(board.castle?(board["E1"].piece, board["H1"].piece)).to eql(false)
        end

        it "returns false if the king has been moved" do
            board = Board.new
            board.setup
            board["E1"].piece.set_moved
            expect(board.castle?(board["E1"].piece, board["H1"].piece)).to eql(false)
        end
        it "returns false if the rook has been moved" do
            board = Board.new
            board.setup
            board["H1"].piece.set_moved
            expect(board.castle?(board["E1"].piece, board["H1"].piece)).to eql(false)
        end
        it "returns false if the pieces are different colors" do
            board = Board.new
            board.setup
            board["H1"].clear_square
            rook = Rook.new("blk")
            board.place_piece(rook, board["H1"])
            expect(board.castle?(board["E1"].piece, board["H1"].piece)).to eql(false)
        end

        it "returns true if all conditions for castling are met" do
            board = Board.new
            board.setup
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["E2"].piece, board["E3"])
            board.move_piece(board["F1"].piece, board["E2"])
            expect(board.castle?(board["E1"].piece, board["H1"].piece)).to eql(true)
        end

    end

    describe "#castle" do
        it "switches the king and the right side rook" do
            board = Board.new
            board.setup
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["E2"].piece, board["E3"])
            board.move_piece(board["F1"].piece, board["E2"])
            board.castle(board["E1"].piece, board["H1"].piece)
            expect(board["H1"].piece.name).to eql("King")
        end
        it "switches the right side rook and the king" do
            board = Board.new
            board.setup           
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["E2"].piece, board["E3"])
            board.move_piece(board["F1"].piece, board["E2"])
            board.castle(board["E1"].piece, board["H1"].piece)
            expect(board["E1"].piece.name).to eql("Rook")
        end
        it "switches the left side rook and the king" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["F4"])
            board.move_piece(board["D1"].piece, board["D2"])

            board.castle(board["E1"].piece, board["A1"].piece)
            expect(board["E1"].piece.name).to eql("Rook")
        end
        it "switches the king and the left side rook" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["F4"])
            board.move_piece(board["D1"].piece, board["D2"])
            board.castle(board["E1"].piece, board["A1"].piece)
            expect(board["A1"].piece.name).to eql("King")
        end
        it "returns true if it executes" do
            board = Board.new
            board.setup
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["E2"].piece, board["E3"])
            board.move_piece(board["F1"].piece, board["E2"])
            expect(board.castle(board["E1"].piece, board["H1"].piece)).to eql(true)
            
        end
        it "returns false if castle? not legal" do
            board = Board.new
            board.setup
            expect(board.castle(board["E1"].piece, board["H8"].piece)).to eql(false)
        end
        it "returns false if the rook is under attack" do
            board = Board.new
            board.setup
            board.move_piece(board["B2"].piece, board["B4"])
            board.move_piece(board["E7"].piece, board["E6"])
            board.move_piece(board["F8"].piece, board["E7"])
            board.move_piece(board["E7"].piece, board["F6"])
            expect(board.castle?(board["E1"].piece, board["A1"].piece)).to eql(false)
        end
        it "returns false if a square between the king and rook is under attack" do
            board = Board.new
            board.setup
            board.move_piece(board["B8"].piece, board["C6"])
            board.move_piece(board["C6"].piece, board["A5"])
            board.move_piece(board["A5"].piece, board["B3"])

            expect(board.castle?(board["E1"].piece, board["A1"].piece)).to eql(false)
        end
    end

    describe "#safe_to_castle?" do
        it "returns true if no square on the path is under attack" do
            board = Board.new
            board.setup
            row = board.get_row(board["E1"])
            path = board.get_path_from_row(row, board["E1"], board["H1"])
            expect(board.safe_to_castle?(board["E1"].piece, board["H1"].piece)).to eql(true)
        end
        it "returns false if any square on the path is under attack" do
            board = Board.new
            board.setup
            board.move_piece(board["B8"].piece, board["C6"])
            board.move_piece(board["C6"].piece, board["A5"])
            board.move_piece(board["A5"].piece, board["B3"])

            expect(board.safe_to_castle?(board["E1"].piece, board["A1"].piece)).to eql(false)
        end

        it "returns false if the rook is under attack" do
            board = Board.new
            board.setup
            board.move_piece(board["B2"].piece, board["B4"])
            board.move_piece(board["E7"].piece, board["E6"])
            board.move_piece(board["F8"].piece, board["E7"])
            board.move_piece(board["E7"].piece, board["F6"])
            expect(board.safe_to_castle?(board["E1"].piece, board["A1"].piece)).to eql(false)
        end

    end

    describe "#place_pieces" do
        it "adds all pieces to @pieces array" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            expect(board.pieces.length).to eql(32)

        end

        it "contains pieces that are on the board" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            expect(board.pieces).to include(board["A1"].piece)
        end

    end

    describe "#move_piece" do
        it "returns false if a move is illegal" do
            board = Board.new
            board.setup
            expect(board.move_piece(
                board["A2"].piece, 
                board["B3"]
                )).to eql(false)
        end

        it "returns true if a move is legal" do
            board = Board.new
            board.setup

            expect(board.move_piece(
                board["A2"].piece, 
                board["A3"]
                )).to eql(true)
        end

        it "resets the piece value of the square the piece moved from to nil" do
            board = Board.new
            board.setup
            board.move_piece(board["B2"].piece, board["B3"])
            expect(board["B2"].piece).to eql(nil)
        end

        it "resets the symbol value of the square the piece moved from to empty space" do    
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.get_piece_moves
            board.move_piece(board["B2"].piece, board["B3"])
            expect(board["B2"].symbol).to eql(" ")
        end

        it "sets a piece's moved value to true" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A4"])
            expect(board["A4"].piece.moved).to eql(true)
        end

        it "will replace a piece that is on the square moved to" do
            board = Board.new
            board.setup

            board.move_piece(board["B2"].piece, board["B4"])
            # Kill the pawn
            board.move_piece(board["A7"].piece, board["A5"])
            board.move_piece(board["B4"].piece, board["A5"])
            expect(board["A5"].symbol).to eql("♙")
        end
        
        it "updates a piece's available moves correclty" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A4"])
            expect(board["A4"].piece.available_moves).to include(board["A5"].name)
        end

        it "updates the moves for other pieces when a piece is moved" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A4"])
            expect(board["A1"].piece.available_moves).to include(board["A3"].name)
        end

        it "correctly moves a white pawn 1 square forward" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A3"])
            expect(board["A3"].symbol).to eql("♙")
        end

        it "correclty moves a white pawn 2 squares forward if unmoved" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A4"])
            expect(board["A4"].symbol).to eql("♙")
        end

        it "correctly moves a black pawn 1 square forward" do
            board = Board.new
            board.setup
            board.move_piece(board["B7"].piece, board["B6"])
            expect(board["B6"].symbol).to eql("♟︎")
        end

        it "correctly moves a black pawn 2 squares forward if unmoved" do
            board = Board.new
            board.setup
            board.move_piece(board["B7"].piece, board["B5"])
            expect(board["B5"].symbol).to eql("♟︎")
        end

        it "correctly moves a knight in an L shape" do
            board = Board.new
            board.setup
            expect(board.move_piece(
                board["B1"].piece,
                board["A3"]
            )).to eql(true)
        end
        it "correctly moves a knight in an L shape" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["A3"])
            expect(board.move_piece(
                board["A3"].piece,
                board["B5"]
            )).to eql(true)
        end
        it "correctly moves a knight in an L shape" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["B5"])

            expect(board.move_piece(
                board["B5"].piece,
                board["D4"]
            )).to eql(true)
        end
        it "correctly moves a knight in an L shape" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["B5"])
            board.move_piece(board["B5"].piece, board["D4"])


            expect(board.move_piece(
                board["D4"].piece,
                board["F5"]
            )).to eql(true)
        end
        it "correctly moves a knight in an L shape" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["B5"])
            board.move_piece(board["B5"].piece, board["D4"])
            board.move_piece(board["D4"].piece, board["F5"])

            expect(board.move_piece(
                board["F5"].piece,
                board["D4"]
            )).to eql(true)
        end
        it "correctly moves a knight in an L shape" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["B5"])
            board.move_piece(board["B5"].piece, board["D4"])
            board.move_piece(board["D4"].piece, board["F5"])
            board.move_piece(board["F5"].piece, board["D4"])

            expect(board.move_piece(
                board["D4"].piece,
                board["B5"]
            )).to eql(true)
        end
        it "correctly moves a knight in an L shape" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["B5"])
            board.move_piece(board["B5"].piece, board["D4"])
            board.move_piece(board["D4"].piece, board["F5"])
            board.move_piece(board["F5"].piece, board["D4"])
            board.move_piece(board["D4"].piece, board["B5"])


            expect(board.move_piece(
                board["B5"].piece,
                board["C3"]
            )).to eql(true)
        end        
        it "correctly moves a knight in an L shape" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["B5"])
            board.move_piece(board["B5"].piece, board["D4"])
            board.move_piece(board["D4"].piece, board["F5"])
            board.move_piece(board["F5"].piece, board["D4"])
            board.move_piece(board["D4"].piece, board["B5"])
            board.move_piece(board["B5"].piece, board["C3"])

            expect(board.move_piece(
                board["C3"].piece,
                board["B1"]
            )).to eql(true)
        end

        it "correctly moves a rook vertically" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A4"])
            expect(board.move_piece(
                board["A1"].piece,
                board["A3"]
            )).to eql(true)
        end
        it "correctly moves a rook horizontally" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A4"])
            board.move_piece(board["A1"].piece, board["A3"])

            expect(board.move_piece(
                board["A3"].piece,
                board["G3"]
            )).to eql(true)
        end
        it "won't move a rook over another piece" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A4"])
            expect(board.move_piece(
                board["A1"].piece,
                board["A5"]
            )).to eql(false)
        end

        it "moves a bishop correctly" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            expect(board.move_piece(
                board["C1"].piece,
                board["G5"]
            )).to eql(true)
        end

        it "moves a queen correctly vertically" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            board.move_piece(board["D4"].piece, board["D5"])

            expect(board.move_piece(
                board["D1"].piece,
                board["D4"]
            )).to eql(true)
        end

        it "moves a queen correctly diagonally" do
            board = Board.new
            board.setup
            board.move_piece(board["C2"].piece, board["C4"])
            expect(board.move_piece(
                board["D1"].piece,
                board["A4"]
            )).to eql(true)
        end
        it "moves a queen correctly horizontally" do
            board = Board.new
            board.setup
            board.move_piece(board["C2"].piece, board["C3"])
            board.move_piece(board["D1"].piece, board["A4"])
            expect(board.move_piece(
                board["A4"].piece,
                board["G4"]
            )).to eql(true)
        end

        it "moves a king correctly" do
            board = Board.new
            board.setup
            board.move_piece(board["E2"].piece, board["E4"])
            expect(board.move_piece(
                board["E1"].piece, 
                board["E2"]
                )).to eql(true)
        end

        it "returns false for an illegal king move" do
            board = Board.new
            board.setup
            board.move_piece(board["E2"].piece, board["E4"])
            expect(board.move_piece(
                board["E1"].piece, 
                board["E3"]
                )).to eql(false)
        end

        it "won't let a king move into check" do
            board = Board.new
            board.setup
            board.move_piece(board["E2"].piece, board["E4"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["C5"])
            board.move_piece(board["E1"].piece, board["E2"])
            board.move_piece(board["D8"].piece, board["G5"])
            expect(board.move_piece(
                board["E2"].piece, 
                board["E3"]
                )).to eql(false)
        end
    end

    describe "#set_moved" do
        it "sets an unmoved piece's moved value to true" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.get_piece_moves

            board.set_moved(board["A2"].piece)
            expect(board["A2"].piece.moved).to eql(true)
        end

        it "returns false if a piece is already moved" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.get_piece_moves

            board.move_piece(board["A2"].piece, board["A3"])
            
            expect(board.set_moved(
                board["A3"].piece
            )).to eql(false)
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


        it "returns false if the squares are not diagonal" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.diagonal?(
                board["D8"],
                board["B5"]
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

    describe "#two_squares vertical" do
        it "returns false if either square is nil" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.two_squares_vertical?(
                nil,
                board["A2"]
            )).to eql(false)
        end

        it "returns true if a square is vertical and two squares away from source" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.two_squares_vertical?(
                board["A2"],
                board["A4"]
            )).to eql(true)
        end


        it "returns false if a square is vertical and >2 squares away from source" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.two_squares_vertical?(
                board["A2"],
                board["A5"]
            )).to eql(false)
        end


        it "returns false if a square is vertical and <2 squares away from source" do
            board = Board.new
            board.create_board(board.board_array)
            expect(board.two_squares_vertical?(
                board["A2"],
                board["A3"]
            )).to eql(false)
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

        it "returns true for X+2, Y-1" do
            board = Board.new
            board.setup
            expect(board.knight_move?(
                board["D4"], 
                board["C6"]
                )).to eql(true)
        end

        it "returns true for X+2, Y+1" do
            board = Board.new
            board.setup
            expect(board.knight_move?(
                board["D4"],
                board["E6"]
                )).to eql(true)
        end

        it "returns true for X-2, Y-1" do
            board = Board.new
            board.setup
            expect(board.knight_move?(
                board["D4"],
                board["C2"]
                )).to eql(true)
        end

        it "returns true for X-2, Y+1" do
            board = Board.new
            board.setup
            expect(board.knight_move?(
                board["D4"],
                board["E2"]
                )).to eql(true)
        end

        it "returns true for X+1, Y+2" do
            board = Board.new
            board.setup
            expect(board.knight_move?(
                board["D4"],
                board["F5"]
                )).to eql(true)
        end

        it "returns true for X+1, Y-2" do
            board = Board.new
            board.setup
            expect(board.knight_move?(
                board["D4"],
                board["B5"]
                )).to eql(true)
        end

        it "returns true for X-1, Y+2" do
            board = Board.new
            board.setup
            expect(board.knight_move?(
                board["D4"],
                board["F3"]
                )).to eql(true)
        end

        it "returns true for X-1, Y-2" do
            board = Board.new
            board.setup
            expect(board.knight_move?(
                board["D4"],
                board["B3"]
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

        it "returns false if the square is attacked" do
            board = Board.new
            board.setup
            board.move_piece(board["E2"].piece, board["E4"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["C5"])
            board.move_piece(board["E1"].piece, board["E2"])
            board.move_piece(board["D8"].piece, board["G5"])
            expect(board.king_move?(
                board["E2"], 
                board["E3"]
                )).to eql(false)
        end
    end

    describe "#pawn_direction?" do
        it "returns false if a white pawn is trying to move backwards" do
            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("wht")
            board.place_piece(pawn, board["A5"])
            expect(board.pawn_direction?(
                board["A5"], 
                board["A4"]
                )).to eql(false)
        end

        it "returns true if a white pawn is moving forwards" do
            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("wht")
            board.place_piece(pawn, board["A5"])
            expect(board.pawn_direction?(
                board["A5"], 
                board["A6"]
                )).to eql(true)
        end

        it "returns false if a black pawn is trying to move backwards" do
            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("blk")
            board.place_piece(pawn, board["A5"])
            expect(board.pawn_move?(
                board["A5"], 
                board["A6"]
                )).to eql(false)
        end

        it "returns true if a black pawn is moving forwards" do
            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("blk")
            board.place_piece(pawn, board["A5"])
            expect(board.pawn_move?(
                board["A5"], 
                board["A4"]
                )).to eql(true)
        end
    end

    describe "#pawn_move" do
        it "returns false if a square is neither vertical nor adjacent" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.get_piece_moves
            expect(board.pawn_move?(
                board["B2"], 
                board["A3"]
                )).to eql(false)
        end 

        it "returns true if a pawn has not been moved and the square is two squares forward" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.get_piece_moves
            expect(board.pawn_move?(
                board["A2"],
                board["A4"]
            )).to eql(true)
        end

        it "returns false if a pawn has been moved and the square is two squares forward" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.get_piece_moves
            board["A2"].piece.set_moved
            expect(board.pawn_move?(
                board["A2"],
                board["A4"]
            )).to eql(false)
        end

        it "returns false if the pawn has not been moved but the square two squares forward has a piece on it" do
            board = Board.new
            board.setup
            board.move_piece(board["A7"].piece, board["A5"])
            board.move_piece(board["A5"].piece, board["A4"])
            expect(board.pawn_move?(
                board["A2"],
                board["A4"]
            )).to eql(false)
        end

        it "returns true if the forward diagonal square has a piece on it" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["A4"])
            board.move_piece(board["A4"].piece, board["A5"])
            board.move_piece(board["A5"].piece, board["A6"])
            expect(board.pawn_move?(
                board["A6"],
                board["B7"]
            )).to eql(true)
        end

        it "returns false if the forward diagonal square doesn't have a piece on it" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["A4"])
            expect(board.pawn_move?(
                board["A4"],
                board["B5"]
            )).to eql(false)
        end


        it "returns true if a square is vertical and adjacent, and a correct move for a white pawn" do
            board = Board.new
            board.setup
            expect(board.pawn_move?(
                board["A2"], 
                board["A3"]
                )).to eql(true)
        end

        it "returns false if a square is vertical and adjacent, but an illegal move for a white pawn" do
            board = Board.new
            board.setup
            board.move_piece(board["B2"].piece, board["B4"])
            expect(board.pawn_move?(
                board["B4"], 
                board["B3"]
                )).to eql(false)
        end


        it "returns true if a square is vertical and adjacent, and a correct move for a black pawn" do
            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("blk")
            board.place_piece(pawn, board["A3"])
            expect(board.pawn_move?(
                board["A3"], 
                board["A2"]
                )).to eql(true)
        end

        it "returns false if a square is vertical and adjacent, but an illegal move for a black pawn" do
            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("blk")
            board.place_piece(pawn, board["A2"])
            expect(board.pawn_move?(
                board["A2"], 
                board["A3"]
                )).to eql(false)
        end
    end

    describe "#en_passant?" do
        it "returns true if en passant is an available to a pawn" do
            player_one = Player.new("Will", "wht")
            player_two = Player.new("Fernando", "blk")
            board = Board.new
            board.setup

            board.move_piece(board["B2"].piece, board["B4"])
            board.move_piece(board["B4"].piece, board["B5"])
            board.move_piece(board["C7"].piece, board["C5"])
            
            last_move = Move.new(player_two)
            last_move.get_square(board["C5"])
            last_move.get_board(board)
            last_move.get_piece(board["C5"])
            last_move.set_pawn_jump

            expect(board.en_passant?(board["B5"], last_move)).to eql(true)
        end

        it "returns false if en passant is an unavailable to a pawn" do
            player_one = Player.new("Will", "wht")
            player_two = Player.new("Fernando", "blk")
            board = Board.new
            board.setup

            board.move_piece(board["B2"].piece, board["B4"])
            board.move_piece(board["B4"].piece, board["B5"])
            board.move_piece(board["C7"].piece, board["C6"])
            board.move_piece(board["C6"].piece, board["C5"])
            
            last_move = Move.new(player_two)
            last_move.get_square(board["C5"])
            last_move.get_board(board)
            last_move.get_piece(board["C5"])

            expect(board.en_passant?(board["B5"], last_move)).to eql(false)
        end
    end

    describe "#legal_move?" do
        it "returns false for an illegal pawn move" do
            board = Board.new
            board.setup
            expect(board.legal_move?(
                board["B2"].piece,
                board["C3"]
            )).to eql(false)
        end

        it "returns false if moving to a square occupied by one of your own pieces" do
            board = Board.new
            board.setup
            expect(board.legal_move?(
                board["B8"].piece,
                board["D7"]
            )).to eql(false)
        end

        it "returns true for a legal white pawn move" do
            board = Board.new
            board.setup
            expect(board.legal_move?(
                board["A2"].piece,
                board["A4"]
            )).to eql(true)
        end

        it "returns true for a legal black pawn move" do
            board = Board.new
            board.setup
            expect(board.legal_move?(
                board["B7"].piece,
                board["B5"]
            )).to eql(true)
        end

        it "returns false for an illegal knight move" do
            board = Board.new
            board.setup
            expect(board.legal_move?(
                board["B1"].piece,
                board["D3"]
            )).to eql(false)
        end

        it "returns true for a legal knight move L" do
            board = Board.new
            board.setup
            expect(board.legal_move?(
                board["B1"].piece,
                board["C3"]
            )).to eql(true)
        end

        it "returns true for a knight move ⅃" do
            board = Board.new
            board.setup
            expect(board.legal_move?(
                board["B1"].piece,
                board["A3"]
            )).to eql(true)
        end

        it "returns true for a knight move ¬ " do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            expect(board.legal_move?(
                board["C3"].piece,
                board["E4"]
            )).to eql(true)
        end

        it "returns true for a legal bishop move" do
            board = Board.new
            board.setup
            board.move_piece(board["B2"].piece, board["B4"])
            expect(board.legal_move?(
                board["C1"].piece,
                board["A3"]
            )).to eql(true)
        end

        it "returns false for an illegal rook move" do            
            board = Board.new
            board.setup
            expect(board.legal_move?(
                board["A1"].piece,
                board["B3"]
            )).to eql(false)
        end

        it "returns true for a legal vertical rook move" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["A4"])
            board.move_piece(board["A4"].piece, board["A5"])

            expect(board.legal_move?(
                board["A1"].piece,
                board["A4"]
            )).to eql(true)
        end

        it "returns true for a legal horizontal rook move" do
            board = Board.new
            board.setup
            board.move_piece(board["A2"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["A4"])
            board.move_piece(board["A4"].piece, board["A5"])
            board.move_piece(board["A1"].piece, board["A4"])
            expect(board.move_piece(
                board["A4"].piece,
                board["G4"]
            )).to eql(true)
        end

        it "returns false for an illegal queen move" do
            board = Board.new
            board.setup
            board.move_piece(board["D7"].piece, board["D6"])

            expect(board.legal_move?(
                board["D8"].piece,
                board["C5"]
            )).to eql(false)
        end

        it "returns true for a legal queen move" do
            board = Board.new
            board.setup
            board.move_piece(board["C7"].piece, board["C6"])

            expect(board.legal_move?(
                board["D8"].piece,
                board["A5"]
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

        it "returns false if the move would put the king in check" do
            board = Board.new
            board.setup
            board.move_piece(board["E2"].piece, board["E4"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["C5"])
            board.move_piece(board["E1"].piece, board["E2"])
            board.move_piece(board["D8"].piece, board["G5"])
            expect(board.legal_move?(
                board["E2"].piece, 
                board["E3"]
                )).to eql(false)
        end
    end

    describe "#clear_path?" do
        it "returns true if the path between two squares does not contain a piece" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces

            expect(board.clear_path?(board["A3"], board["C4"])).to eql(true)
        end

        it "returns true if the start and end square have pieces but the path is clear" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            expect(board.clear_path?(board["C2"], board["C7"])).to eql(true)
        end

        it "returns true on an unblocked vertical path" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces

            expect(board.clear_path?(
                board["A3"],
                board["A5"]
            )).to eql(true)
        end

        it "returns false on a blocked vertical path" do
            board = Board.new
            board.setup
            expect(board.clear_path?(
                board["A1"],
                board["A5"]
            )).to eql(false)
        end

        it "returns true on an unblocked diagonal path" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces

            expect(board.clear_path?(
                board["A3"],
                board["D6"]
                )).to eql(true)
        end

        it "returns true on an unblocked diagonal path surrounded by pieces" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            board.move_piece(board["E2"].piece, board["E4"])
            board.move_piece(board["F2"].piece, board["F3"])
            board.move_piece(board["D1"].piece, board["E2"])

            expect(board.clear_path?(
                board["C1"],
                board["H6"]
            )).to eql(true)
        end

        it "returns false on a blocked diagonal path" do
            board = Board.new
            board.setup
            expect(board.clear_path?(
                board["A1"],
                board["D3"]
            )).to eql(false)
        end

        it "returns true on a horizontal path not blocked" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces

            expect(board.clear_path?(
                board["A3"],
                board["G3"]
            )).to eql(true)

        end

        it "returns true if path unblocked but surrounded by pieces" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])

            expect(board.clear_path?(
                board["D1"],
                board["D3"]
            )).to eql(true)
        end

        it "returns false on a horizontal path blocked by pieces" do
            board = Board.new
            board.setup
            expect(board.clear_path?(
                board["A2"],
                board["G2"]
            )).to eql(false)
        end

        it "does not count the start square's piece" do
            board = Board.new
            board.setup
            expect(board.clear_path?(
                board["A2"],
                board["A5"]
            )).to eql(true)
        end

        it "does not count the end square's piece" do
            board = Board.new
            board.setup
            expect(board.clear_path?(
                board["A5"],
                board["A2"]
            )).to eql(true)
        end
    end


    describe "#clear_path_horizontal?" do
        it "returns false if there is a piece" do
            board = Board.new
            board.setup
            expect(board.clear_path_horizontal?(
                board["A2"], 
                board["F2"]
                )).to eql(false)
        end

        it "returns true if the path is not blocked by a piece" do
            board = Board.new
            board.setup
            expect(board.clear_path_horizontal?(
                board["A3"], 
                board["F3"]
                )).to eql(true)
        end
    end

    describe "#get_row" do
        it "returns an array containing the source square" do
            board = Board.new
            board.setup
            row = board.get_row(board["A4"])
            expect(row[board["A4"].name]).to eql(board["A4"])
        end

        it "returns an array with squares with the same x coordinate as the source square" do
            board = Board.new
            board.setup
            row = board.get_row(board["A4"])
            expect(row[board["G4"].name]).to eql(board["G4"])
        end

        it "does not contain squares that are not on that row" do
            board = Board.new
            board.setup
            row = board.get_row(board["A4"])
            expect(row[board["G5"].name]).to eql(nil)
        end

        it "contains all the squares on that row" do
            board = Board.new
            board.setup
            row = board.get_row(board["A4"])
            expect(row.size).to eql(8)
        end

    end

    describe "#get_path_from_row" do
        it "returns an empty array if same square or squares adjacent" do
            board = Board.new
            board.setup
            row = board.get_row(board["A4"])
            path = board.get_path_from_row(row, board["A4"], board["B4"])
            expect(path).to eql([])    
        end
        it "returns an array of squares in between the start and end point" do
            board = Board.new
            board.setup
            row = board.get_row(board["A4"])
            path = board.get_path_from_row(row, board["A4"], board["E4"])
            expect(path).to include(board["D4"]) 
        end

        it "contains all the squares in between the start and end point" do
            board = Board.new
            board.setup
            row = board.get_row(board["A4"])
            path = board.get_path_from_row(row, board["A4"], board["E4"])
            expect(path.size).to eql(3)
        end
        
        it "does not contain the start square" do
            board = Board.new
            board.setup
            row = board.get_row(board["A4"])
            path = board.get_path_from_row(row, board["A4"], board["E4"])
            expect(path).to_not include(board["A4"]) 
        end

        it "does not contain the end square" do
            board = Board.new
            board.setup
            row = board.get_row(board["A4"])
            path = board.get_path_from_row(row, board["A4"], board["E4"])
            expect(path).to_not include(board["E4"]) 
        end
    end

    describe "#clear_path_vertical?" do
        it "returns false if there is a piece" do
            board = Board.new
            board.setup
            expect(board.clear_path_vertical?(
                board["A1"], 
                board["A5"]
                )).to eql(false)
        end

        it "returns true if the path is not blocked by a piece" do
            board = Board.new
            board.setup
            expect(board.clear_path_vertical?(
                board["C2"], 
                board["C5"]
                )).to eql(true)
        end

        it "returns true if only the start square has a piece" do
            board = Board.new
            board.setup
            expect(board.clear_path_vertical?(
                board["B2"], 
                board["B4"]
                )).to eql(true)
        end
        it "returns true if only the end square has a piece" do
            board = Board.new
            board.setup
            expect(board.clear_path_vertical?(
                board["B4"], 
                board["B2"]
                )).to eql(true)
        end
    end

    describe "#get_column" do
        it "returns an array containing the source square" do
            board = Board.new
            board.setup
            column = board.get_column(board["A4"])
            expect(column[board["A4"].name]).to eql(board["A4"])
        end

        it "returns an array with squares with the same y coordinate as the source square" do
            board = Board.new
            board.setup
            column = board.get_column(board["A4"])
            expect(column[board["A6"].name]).to eql(board["A6"])
        end

        it "does not contain squares that are not in that column" do
            board = Board.new
            board.setup
            column = board.get_column(board["A4"])
            expect(column[board["G5"].name]).to eql(nil)
        end

        it "contains all the squares in that column" do
            board = Board.new
            board.setup
            column = board.get_column(board["A4"])
            expect(column.size).to eql(8)
        end
    end

    describe "#get_path_from_column" do
        it "returns an empty array if same square or squares adjacent" do
            board = Board.new
            board.setup
            column = board.get_column(board["A4"])
            path = board.get_path_from_column(column, board["A1"], board["A2"])
            expect(path).to eql([])    
        end
        it "returns an array of squares in between the start and end point" do
            board = Board.new
            board.setup
            column = board.get_column(board["A4"])
            path = board.get_path_from_column(column, board["A4"], board["A6"])
            expect(path).to include(board["A5"]) 
        end

        it "contains all the squares in between the start and end point" do
            board = Board.new
            board.setup
            column = board.get_column(board["A4"])
            path = board.get_path_from_column(column, board["A1"], board["A5"])
            expect(path.size).to eql(3)
        end

        it "does not contain squares from that column but not between the start and end point" do
            board = Board.new
            board.setup
            column = board.get_column(board["A4"])
            path = board.get_path_from_column(column, board["A2"], board["A6"])
            expect(path).to_not include(board["A7"]) 
        end
        
        it "does not contain the start square" do
            board = Board.new
            board.setup
            column = board.get_column(board["A4"])
            path = board.get_path_from_column(column, board["A4"], board["A7"])
            expect(path).to_not include(board["A4"]) 
        end

        it "does not contain the end square" do
            board = Board.new
            board.setup
            column = board.get_column(board["A4"])
            path = board.get_path_from_column(column, board["A4"], board["A7"])
            expect(path).to_not include(board["A7"]) 
        end

        it "works correctly going backwards" do
            board = Board.new
            board.setup
            column = board.get_column(board["A4"])
            path = board.get_path_from_column(column, board["A7"], board["A2"])
            expect(path).to_not include(board["A2"]) 
        end
    end

    describe "#blockable_check?" do
        it "returns true if the attack can be intercepted" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            board.move_piece(board["D1"].piece, board["D2"])
            board.move_piece(board["D2"].piece, board["A5"])
            board.move_piece(board["A5"].piece, board["B6"])
            board.move_piece(board["C7"].piece, board["C6"])

            attack_path = board.get_attack_path(board["B6"].piece, board["B7"])

            expect(board.blockable_check?(board["B6"].piece, attack_path)).to eql(true)
        end

        it "returns true if the attack path can be blocked" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            board.move_piece(board["D1"].piece, board["D2"])
            board.move_piece(board["D2"].piece, board["A5"])
            board.move_piece(board["C7"].piece, board["C6"])

            attack_path = board.get_attack_path(board["A5"].piece, board["B7"])

        end

        it "returns false if the attack cannot be blocked or intercepted" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            board.move_piece(board["D1"].piece, board["D2"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["D3"].piece, board["A3"])



            attack_path = board.get_attack_path(board["A3"].piece, board["E7"])

            expect(board.blockable_check?(board["A3"].piece, attack_path)).to eql(false)
        end
    end

    describe "#get_attack_path" do
        it "returns an array of squares" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            board.move_piece(board["D1"].piece, board["D2"])
            board.move_piece(board["D2"].piece, board["A5"])

            expect(board.get_attack_path(board["A5"].piece, board["A7"])).to include(board["A6"])
        end
        it "contains the right number of squares" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            board.move_piece(board["D1"].piece, board["D2"])
            board.move_piece(board["D2"].piece, board["C3"])
            path = board.get_attack_path(board["C3"].piece, board["C7"])
            expect(path.length).to eql(3)
        end
        it "contains a path when called on horizontal squares" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            board.move_piece(board["D1"].piece, board["D2"])
            board.move_piece(board["D2"].piece, board["A5"])
            board.move_piece(board["D7"].piece, board["D5"])
            path = board.get_attack_path(board["A5"].piece, board["D5"])
            expect(path).to include(board["B5"])
        end
        it "contains a path when called on diagonal squares" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            board.move_piece(board["D1"].piece, board["D2"])
            board.move_piece(board["D2"].piece, board["B4"])
            path = board.get_attack_path(board["B4"].piece, board["E7"])
            expect(path).to include(board["D6"])
        end
        it "contains a path when called on diagonal squares" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            board.move_piece(board["D1"].piece, board["D2"])
            board.move_piece(board["D2"].piece, board["B4"])
            path = board.get_attack_path(board["B4"].piece, board["E7"])
            expect(path).to include(board["D6"])
        end
        it "contains a path when called on diagonal squares" do
            board = Board.new
            board.setup
            board.move_piece(board["D2"].piece, board["D4"])
            board.move_piece(board["D1"].piece, board["D2"])
            board.move_piece(board["D2"].piece, board["B4"])
            path = board.get_attack_path(board["B4"].piece, board["E1"])
            expect(path).to include(board["D2"])
        end
    end

    describe "#board_scan" do
        it "creates a hash that isn't empty" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            map = board.board_scan(board["A1"])
            expect(map).to_not eql({})
        end

        it "has values that can be accessed" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            map = board.board_scan(board["A1"])
            expect(map["A1"]).to_not eql(nil)
        end

        it "gives the source square a predecessor value of nil" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            map = board.board_scan(board["A1"])
            expect(map["A1"][:predecessor]).to eql(nil)
        end

        it "gives the source square a distance value of 0" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            map = board.board_scan(board["A1"])
            expect(map["A1"][:distance]).to eql(0)
        end

        it "gives non-source squares a predecessor value of not nil" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            map = board.board_scan(board["A1"])
            expect(map["A2"][:predecessor]).to_not eql(nil)
        end

        it "gives a square the correct predecessor value" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            map = board.board_scan(board["A1"])
            expect(map["A2"][:predecessor]).to eql(board["A1"])
        end
    end

    describe "#attacks_scan" do
        it "returns an empty array if square not attacked" do
            board = Board.new
            board.setup
            map = board.attacks_scan(board["A2"].piece, board["A2"])
            expect(map).to eql([])
        end

        it "returns an array of pieces attacking the square" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])

            map = board.attacks_scan( 
                board["E7"].piece,
                board["E7"]
            )
            expect(map).to include(board["D5"].piece)
        end

        it "returns the an array with the correct number of pieces" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["G5"])



            map = board.attacks_scan( 
                board["E7"].piece,
                board["E7"]
            )
            expect(map.length).to eql(3)
        end

        it "works correctly on an empty square" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["B2"].piece, board["B3"])
            board.move_piece(board["B3"].piece, board["B4"])
            board.move_piece(board["B4"].piece, board["B5"])

            map = board.attacks_scan(
                board["A7"].piece,
                board["B4"]
            )
            expect(map).to include(board["C6"].piece)
        end

        it "returns empty array if square not attacked by enemy piece" do
            board = Board.new
            board.setup
            map = board.attacks_scan(
                board["E1"].piece,
                board["E2"]
            )
            expect(map.length).to eql(0)
        end
    end

    describe "#under_attack?" do
        it "returns true if a square is under attack" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["G5"])
            expect(board.under_attack?(
                board["A7"].piece,
                board["B4"]
                )).to eql(true)

        end

        it "returns true if square is under attack" do
            board = Board.new
            board.setup
            board.move_piece(board["E2"].piece, board["E4"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["C5"])
            board.move_piece(board["E1"].piece, board["E2"])

            expect(board.under_attack?(
                board["E2"].piece,
                board["E3"]
                    )).to eql(true)
        end
        
        it "returns false if a square is not under attack" do
            board = Board.new
            board.setup
            expect(board.under_attack?(
                board["A1"].piece,
                board["A1"]
                )).to eql(false)
        end
    end

    describe "#check?" do
        it "returns true if the king is in check" do
            board = Board.new
            board.setup
            board.move_piece(board["B8"].piece, board["C6"])
            board.move_piece(board["C6"].piece, board["D4"])
            board.move_piece(board["D4"].piece, board["F3"])
            expect(board.check?(board["E1"].piece)).to eql(true)
        end

        it "returns false if the king is not in check" do
            board = Board.new
            board.setup
            expect(board.check?(board["E8"].piece)).to eql(false)
        end



    end

    describe "#checkmate" do
        it "return false if the king can move out of check" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["G5"])
            board.move_piece(board["D1"].piece, board["C1"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["B4"])
            expect(board.checkmate?(board["E1"].piece)).to eql(false)
        end
        it "returns false if the attacking piece can be taken" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["G5"])
            board.move_piece(board["A2"].piece, board["A3"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["B4"])
            expect(board.checkmate?(board["E1"].piece)).to eql(false)
        end
        it "returns false if the attack path can be blocked by a move" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["G5"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["B4"])
            expect(board.checkmate?(board["E1"].piece)).to eql(false)
        end
        it "returns true if the king is in checkmate" do
            board = Board.new
            board.setup
            board.move_piece(board["F7"].piece, board["F6"])
            board.move_piece(board["E2"].piece, board["E4"])
            board.move_piece(board["G7"].piece, board["G5"])
            board.move_piece(board["D1"].piece, board["H5"])
            expect(board.checkmate?(board["E8"].piece)).to eql(true)

        end
    end


    describe "#get_attackers_and_paths" do
        it "returns an array of arrays with 2 items each" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["G5"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["B4"])

            attackers = board.get_attackers_and_paths(board["E1"].piece)
            expect(attackers[0].length).to eql(2)
        end
        it "returns an array of arrays with pieces and paths" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["G5"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["B4"])

            attackers = board.get_attackers_and_paths(board["E1"].piece)
            expect(attackers[0]).to include(board["B4"].piece)
        end
        it "returns an array of arrays with pieces and paths where the paths contain squares" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["G5"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["B4"])

            attackers = board.get_attackers_and_paths(board["E1"].piece)
            attack = attackers[0]
            expect(attack[1]).to include(board["D2"])
        end
        it "returns an array with path length of correct size" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["G5"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["B4"])

            attackers = board.get_attackers_and_paths(board["E1"].piece)
            attack = attackers[0]
            expect(attack[1].length).to eql(2)
        end
    end

    describe "#any_escape?" do
        it "returns false if the king has no available moves" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["G5"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["F8"].piece, board["B4"])

            expect(board.any_escape?(board["E1"].piece)).to eql(false)
        end

        it "returns true if the king has available moves" do
            board = Board.new
            board.setup
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["D5"])
            board.move_piece(board["G1"].piece, board["F3"])
            board.move_piece(board["F3"].piece, board["E5"])
            board.move_piece(board["E5"].piece, board["C6"])
            board.move_piece(board["D2"].piece, board["D3"])
            board.move_piece(board["C1"].piece, board["G5"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["E2"].piece, board["E4"])

            board.move_piece(board["F8"].piece, board["B4"])

            expect(board.any_escape?(board["E1"].piece)).to eql(true)
        end
    end

end