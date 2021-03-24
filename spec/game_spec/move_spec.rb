require './lib/game/move.rb'

describe Move do
    describe "#initialize" do
        it "initializes" do
            move = Move.new("player_one")
            expect(move).to_not eql(nil)
        end

        it "initializes @player to given value" do
            move = Move.new("player_one")
            expect(move.player).to eql("player_one")
        end
        
        it "initializes @piece to nil" do
            move = Move.new("player_one")
            expect(move.piece).to eql(nil)
        end

        it "initializes @square to nil" do
            move = Move.new("player_one")
            expect(move.square).to eql(nil)
        end
    end
end