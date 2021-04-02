require './lib/board/board.rb'

describe Board do
    describe "#initialize" do
        it "initializes" do
            board = Board.new
            expect(board).to_not eql(nil)
        end

        it "sets @kings to empty array" do
            board = Board.new
            expect(board.kings).to eql([])
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

    describe "#set_kings" do
        it "sets the kings array to have a length of two" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.set_kings([board["E8"].piece, board["E1"].piece])
            expect(board.kings.length).to eql(2)
        end

        it "contains the white king" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.set_kings([board["E8"].piece, board["E1"].piece])
            expect(board.kings[0]).to eql(board["E8"].piece)
        end

        it "contains the black king" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.set_kings([board["E8"].piece, board["E1"].piece])
            expect(board.kings[-1]).to eql(board["E1"].piece)
        end

        it "works when a king is moved" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.set_kings([board["E8"].piece, board["E1"].piece])

            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["E8"].piece, board["E7"])
            expect(board.kings[0]).to eql(board["E7"].piece)
        end
    end

    describe "#move_piece" do
        it "returns false if a move is illegal" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            expect(board.move_piece(
                board["A2"].piece, 
                board["B3"]
                )).to eql(false)
        end

        it "returns true if a move is legal" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces

            
            expect(board.move_piece(
                board["A2"].piece, 
                board["A3"]
                )).to eql(true)
        end

        it "resets the piece value of the square the piece moved from to nil" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.move_piece(board["B1"].piece, board["C3"])
            expect(board["B1"].piece).to eql(nil)
        end

        it "resets the symbol value of the square the piece moved from to empty space" do    
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.move_piece(board["B1"].piece, board["C3"])
            expect(board["B1"].symbol).to eql(" ")
        end

        it "will replace a piece that is on the square moved to" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            # Moving a Knight down the board
            board.move_piece(board["B1"].piece, board["C3"])
            board.move_piece(board["C3"].piece, board["A4"])
            # Move a pawn one space forward
            board.move_piece(board["B7"].piece, board["B6"])
            # Kill the pawn
            board.move_piece(board["A4"].piece, board["B6"])

            expect(board["B6"].symbol).to eql("♘")
        end
    end

    describe "#set_moved" do
        it "sets an unmoved piece's moved value to true" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces

            board.set_moved(board["A2"].piece)
            expect(board["A2"].piece.moved).to eql(true)
        end

        it "returns false if a piece is already moved" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
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

    describe "#attacks" do
        it "returns an empty array if the king is not in check" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            expect(board.attacks(board["E8"].piece)).to eql([])
        end

        it "returns an array of pieces that can attack the king" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.move_piece(board["B8"].piece, board["C6"])
            board.move_piece(board["C6"].piece, board["D4"])
            board.move_piece(board["D4"].piece, board["F3"])
            board.print_board

            attacks = board.attacks(board["E1"].piece)

            expect(attacks).to include(board["F3"].piece)
            
        end

        it "contains all the pieces that can attack the king" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.move_piece(board["B8"].piece, board["C6"])
            board.move_piece(board["C6"].piece, board["D4"])
            board.move_piece(board["D4"].piece, board["F3"])
            board.move_piece(board["E7"].piece, board["E5"])
            board.move_piece(board["D8"].piece, board["G5"])
            board.move_piece(board["G5"].piece, board["D2"])
            attacks = board.attacks(board["E1"].piece)
            expect(attacks.length).to eql(2)
        end

        it "doesn't contain any of the player's own pieces" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            expect(board.attacks(board["E1"].piece)).to_not include(board["D1"].piece)
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
            pawn = Pawn.new("wht")
            board.place_piece(pawn, board["B4"])
            expect(board.pawn_move?(
                board["B4"], 
                board["A3"]
                )).to eql(false)
        end 

        it "returns true if a pawn has not been moved and the square is two squares forward" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
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
            board["A2"].piece.set_moved
            expect(board.pawn_move?(
                board["A2"],
                board["A4"]
            )).to eql(false)
        end

        it "returns false if the pawn has not been moved but the square two squares forward has a piece on it" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.move_piece(board["A7"].piece, board["A5"])
            board.move_piece(board["A5"].piece, board["A4"])
            expect(board.pawn_move?(
                board["A2"],
                board["A4"]
            )).to eql(false)
        end

        it "returns true if the forward diagonal square has a piece on it" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
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
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.move_piece(board["A2"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["A4"])
            expect(board.pawn_move?(
                board["A4"],
                board["B5"]
            )).to eql(false)
        end


        it "returns true if a square is vertical and adjacent, and a correct move for a white pawn" do
            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("wht")
            board.place_piece(pawn, board["A5"])
            expect(board.pawn_move?(
                board["A5"], 
                board["A6"]
                )).to eql(true)
        end

        it "returns false if a square is vertical and adjacent, but an illegal move for a white pawn" do
            board = Board.new
            board.create_board(board.board_array)
            pawn = Pawn.new("wht")
            board.place_piece(pawn, board["A5"])
            expect(board.pawn_move?(
                board["A5"], 
                board["A4"]
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
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces

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
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces

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
            board.create_board(board.board_array)

            pawn = Pawn.new("wht")
            board.place_piece(pawn, board["A5"])
            expect(board.legal_move?(
                pawn,
                board["B4"]
            )).to eql(false)
        end

        it "returns true for a legal white pawn move" do
            board = Board.new
            board.create_board(board.board_array)

            pawn = Pawn.new("wht")
            board.place_piece(pawn, board["A5"])
            expect(board.legal_move?(
                pawn,
                board["A6"]
            )).to eql(true)
        end

        it "returns true for a legal black pawn move" do
            board = Board.new
            board.create_board(board.board_array)

            pawn = Pawn.new("blk")
            board.place_piece(pawn, board["A5"])
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
            board.add_edges
            board.place_pieces
            expect(board.legal_move?(
                board["C1"].piece,
                board["D5"]
            )).to eql(false)
        end

        it "returns true for a legal bishop move" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.move_piece(board["D2"].piece, board["D3"])
            expect(board.legal_move?(
                board["C1"].piece,
                board["F4"]
            )).to eql(true)
        end

        it "returns false for an illegal rook move" do            
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.move_piece(board["A2"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["A4"])
            board.move_piece(board["A4"].piece, board["A5"])

            board.move_piece(board["A1"].piece, board["A3"])
            expect(board.legal_move?(
                board["A3"].piece,
                board["B4"]
            )).to eql(false)
        end

        it "returns true for a legal rook move" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.move_piece(board["A2"].piece, board["A3"])
            board.move_piece(board["A3"].piece, board["A4"])
            board.move_piece(board["A4"].piece, board["A5"])

            expect(board.legal_move?(
                board["A1"].piece,
                board["A4"]
            )).to eql(true)
        end

        it "returns false for an illegal queen move" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            board.move_piece(board["D7"].piece, board["D6"])

            expect(board.legal_move?(
                board["D8"].piece,
                board["C5"]
            )).to eql(false)
        end

        it "returns true for a legal queen move" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
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

        it "returns false if the path between two squares is blocked by a piece" do
            board = Board.new
            board.create_board(board.board_array)
            board.add_edges
            board.place_pieces
            expect(board.clear_path?(board["A1"], board["A5"])).to eql(false)
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

end