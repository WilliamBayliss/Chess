require '../lib/players/player.rb'

describe Player do
    describe "#initialize" do
        it "initializes" do
            player = Player.new("David", 0)
            expect(player).to_not eql(nil)
        end

        it "initializes with a name" do
            player = Player.new("David", 0)
            expect(player.name).to eql("David")
        end

        it "initializes with a color" do
            player = Player.new("David", 0)
            expect(player.color).to eql(0)
        end

        it "initializes with a king value of nil" do
            player = Player.new("Michael", 1)
            expect(player.king).to eql(nil)
        end

    end

    describe "#set_king" do
        it "saves a king as the @king value" do
            player = Player.new("William", 0)
            king = King.new(0)
            player.set_king(king)
            expect(player.king).to eql(king)
        end
    end

end