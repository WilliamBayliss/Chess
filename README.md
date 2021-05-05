# Chess
A chess game for two players on the cmd. To launch, navigate to the directory in your terminal and run $ ruby chess.rb

The game will create player 1 by getting their name and asking them to choose between white and black, and then get player 2's name and assigning them to the other colour.
Players will then take turns selecting a piece by entering the coordinate the piece is on, and then the coordinate they would like that piece to move to.
The game is saved at every turn, if a player makes a move that would leave/put their king in check then it reloads from the start of their turn.

Gained a lot of experience working with many different functions and classes. Developed TDD style with RSpec, used a Graph for the board and had to write lots
of different methods to check for specific edge-case scenarios like castling and check/checkmate.

TODO: adding en passant for pawns, more bug-testing to confirm that checkmate is triggered in the right scenarios.
