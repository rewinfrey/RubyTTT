require 'spec_helper'
require 'ttt/config_options'

module TTT
  describe Setup do
    let(:setup) { Setup.new }

    describe "#new_game" do
      it "returns a new game object after instantiating the players, board, db and game history" do
        game = setup.new_game(player1: "Human", player2: "AI Easy", board: "3x3")
        game.player1.class.should == Human
        game.player2.class.should == AIEasy
        game.player1.side.should  == "x"
        game.player2.side.should  == "o"
        game.board.class.should   == ThreeByThree
        game.history.should_not be_nil
      end
    end

    describe "#new_db" do
      it "returns a new db object" do
        db = setup.new_db
        db.should respond_to(:client)
        db.should respond_to(:bucket)
        db.should respond_to(:cur_id)
        db.should respond_to(:save_game)
        db.should respond_to(:get_game)
        db.should respond_to(:add_game)
        db.should respond_to(:game_list)
      end
    end

    describe "#players" do
      it "returns a list of player types supported by the library" do
        setup.players.should == ConfigOptions::HUMAN_READABLE_PLAYERS
      end
    end

    describe "#boards" do
      it "returns a list of board types supported by the library" do
        setup.boards.should == ConfigOptions::HUMAN_READABLE_BOARDS
      end
    end

    describe "#db" do
      it "returns the db const specified in the config options file" do
        setup.db.should == ConfigOptions::DB
      end
    end

    describe "#interactor" do
      it "returns the interactor const specified in the config options file" do
        setup.interactor.should == ConfigOptions::INTERACTOR
      end
    end

    describe "#new_interactor" do
      it "returns an instance of a game interactor" do
        setup.new_interactor.class.should == GameInteractor
      end
    end
  end
end
