Dir["./lib/pieces/*.rb"].each {|file| require file }
Dir["./lib/players/*.rb"].each {|file| require file }
Dir["./lib/board/*.rb"].each {|file| require file }
Dir["./lib/game/*.rb"].each {|file| require file }

class Chess
    def initialize
        @game = Game.new
        startup
    end

    def startup 
        if File.exists?("saves/save_game.txt")
            puts "There is a save game, would you like to load it? Y/N"
            input = gets.chomp
            until input.upcase == "Y" || input.upcase == "N"
                puts "Invalid input. Please enter Y for yes or N for no."
                input = gets.chomp
            end
            if input.upcase == "Y"
                @game.load_game
            elsif input.upcase == "N"
                puts "This will override your last save, is that ok?"
                input = gets.chomp
                until input.upcase == "Y" || input.upcase == "N"
                    puts "Invalid input. Please enter Y for yes or N for no."
                end
                if input.upcase == "Y"
                    @game.initial_setup
                    @game.run_game
                else
                    @game.load_game
                end
            end
        else
            puts "No save file detected, starting new game..."
            @game.initial_setup
            @game.run_game
        end
    end
end
game = Chess.new