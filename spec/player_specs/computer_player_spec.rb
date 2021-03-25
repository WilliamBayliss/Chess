require './lib/players/computer_player.rb'

describe ComputerPlayer do
    describe "#initialize" do
        it "initializes" do
            cpu = ComputerPlayer.new("wht")
            expect(cpu).to_not eql(nil)
        end

        it "initializes with a name of CPU" do
            cpu = ComputerPlayer.new("wht")
            expect(cpu.name).to eql("CPU")
        end

        it "initializes with a color" do
            cpu = ComputerPlayer.new("wht")
            expect(cpu.color).to eql("wht")
        end

    end

end