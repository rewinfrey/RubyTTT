require 'spec_helper'

module TTT
  describe RiakDB do
    Riak.disable_list_keys_warnings = true

    let(:players) { GameBuilder.new.players }
    let(:boards)  { GameBuilder.new.boards  }
    let(:game)    { GameBuilder.new.new_game(player1: players.first, player2: players.first, board: boards.first) }
    let(:riak)    { GameBuilder.new.new_db(bucket: "ttt_test_list") }

    describe "#new" do
      it "establishes a connection with the Riak cluster" do
      riak.client.should_not be_nil
      end
    end

    describe "#add_game" do
      it "adds a game to the game_list bucket" do
        riak.add_game(:list_name => "ttt_test_list", :game => game)
        riak.client['ttt_test_list'].keys.length.should_not == 0
      end
    end

    describe "#game_list" do
      it "returns a list of games available in the specified game bucket" do
        riak.game_list(:list_name => "ttt_test_list").should_not == ""
      end
    end

    describe "#load_game" do
      it "returns a game object from the Riak datastore" do
        riak.load_game(:list_name => "ttt_test_list", :id => "7").class.should == Game
      end
    end

    describe "#save_game" do
      it "saves an existing game to the Riak datastore" do
        riak.add_game(:list_name => "ttt_test_list", :game => game)
        id = riak.game_list(:list_name => "ttt_test_list").last
        game.board[] = %w(a b c d e f g h i)
        riak.save_game(:list_name => "ttt_test_list", :id => id, :game => game)
        saved_game = riak.client['ttt_test_list'].get(id)
        saved_game.data[:game].board[].should == game.board[]
      end
    end
  end
end
