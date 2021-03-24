require '../lib/players/player.rb'

describe Player do
    describe "#initialize" do
        it "initializes" do
            player = Player.new("David", "wht")
            expect(player).to_not eql(nil)
        end

        it "initializes with a name" do
            player = Player.new("David", "wht")
            expect(player.name).to eql("David")
        end

        it "initializes with a color" do
            player = Player.new("David", "wht")
            expect(player.color).to eql("wht")
        end

    end

end