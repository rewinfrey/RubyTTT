require 'spec_helper'

module TTT
  describe GameBuilder do
    let(:game_builder) { GameBuilder.new }

    describe "#new_game" do
      it "returns a new game object after instantiating the players, board, db and game history" do
        game = game_builder.new_game(player1: "Human", player2: "AI Easy", board: "3x3")
        game.player1.class.should == TTT::Human
        game.player2.class.should == TTT::AIEasy
        game.player1.side.should  == "x"
        game.player2.side.should  == "o"
        game.board.class.should   == TTT::ThreeByThree
        game.db.should_not be_nil
        game.history.should_not be_nil
      end
    end

    describe "#players" do
      it "returns a list of player types supported by the library" do
        game_builder.players.should == HUMAN_READABLE_PLAYERS
      end
    end

    describe "#boards" do
      it "returns a list of board types supported by the library" do
        game_builder.boards.should == HUMAN_READABLE_BOARDS
      end
    end
  end
end
