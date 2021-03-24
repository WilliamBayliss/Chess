require './lib/game.rb'
describe Game do
    describe "#initialize" do
        it "initializes" do
            game = Game.new
            expect(game).to_not eql(nil)
        end
    end
end