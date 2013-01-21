require 'spec_helper'

module TTT
  describe RiakDB do
    Riak.disable_list_keys_warnings = true
    let(:setup)   { Setup.new }
    let(:players) { setup.players }
    let(:boards)  { setup.boards }
    let(:game)    { setup.new_game(player1: players.first, player2: players.first, board: boards.first) }
    let(:riak)    { setup.new_db }
    let(:bucket)  { riak.bucket }

    describe "#new" do
      it "establishes a connection with the Riak cluster" do
      riak.client.should_not be_nil
      end
    end

    describe "#add_game" do
      it "adds a game to the game_list bucket" do
        @id = riak.add_game(game)
        riak.client[bucket].get(@id).data[:game].should_not == nil
      end
    end

    describe "#game_list" do
      it "returns a list of games available in the specified game bucket" do
        num_keys_in_db = riak.client[bucket].keys.length
        riak.game_list.length.should == num_keys_in_db
      end
    end

    describe "#get_game" do
      it "returns a game object from the Riak datastore" do
        cur_id = riak.cur_id
        riak.get_game(cur_id).class.should == Game
      end

      it "returns nil if there is no game at the specified id" do
        riak.get_game(10000000000000000000).should == nil
      end
    end

    describe "#save_game" do
      it "saves an existing game to the Riak datastore" do
        cur_id = riak.cur_id
        new_game = riak.get_game(cur_id)
        new_game.player1.side = "test"
        riak.save_game(cur_id, new_game)
        after_save = riak.get_game(cur_id)
        new_game.player1.side.should == after_save.player1.side
      end
    end

    describe "#delete_game" do
      it "deletes an existing game from the Riak datastore" do
        id = riak.add_game(game)
        riak.get_game(id).class.should == Game
        riak.delete_game(id)
        riak.client[bucket].get_or_new(id).data.should == nil
      end
    end
  end
end
