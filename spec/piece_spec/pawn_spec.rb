require './lib/pieces/pawn.rb'

describe Pawn do
    describe "#initialize" do
        it "initializes" do
            pawn = Pawn.new("wht")
            expect(pawn).to_not eql(nil)
        end

        it "initializes with a square value of nil" do
            pawn = Pawn.new("wht")
            expect(pawn.square).to eql(nil)
        end

        it "initializes with the correct wht symbol" do
            pawn = Pawn.new("wht")
            expect(pawn.symbol).to eql("♙")
        end

        it "initializes with the correct blk symbol" do
            pawn = Pawn.new("blk")
            expect(pawn.symbol).to eql("♟︎")
        end

        it "initializes with a moved value of false" do
            pawn = Pawn.new("blk")
            expect(pawn.moved).to eql(false)
        end

        it "initializes with an en passant value of nil" do
            pawn = Pawn.new("blk")
            expect(pawn.en_passant).to eql(nil)
        end
    end

    describe "#set_moved" do
        it "sets the moved attr of a pawn to true" do
            pawn = Pawn.new("blk")
            pawn.set_moved
            expect(pawn.moved).to eql(true)
        end
    end

    describe "#register_en_passant" do
        it "sets the en_passant value to a move" do
            move = Move.new("player_one")
            pawn = Pawn.new("blk")
            pawn.register_en_passant(move)

            expect(pawn.en_passant).to eql(move)
        end
    end

end