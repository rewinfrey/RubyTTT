require 'spec_helper'
require 'ttt/config_options'

module TTT
  describe Context do
    let(:context)          { Context.instance }
    let(:setup)            { Setup.new }
    let(:players)          { setup.players }
    let(:boards)           { setup.boards }
    let(:game)             { setup.new_game(player1: players.first, player2: players.first, board: boards.first) }

    before(:each) do
      context.setup=(Setup)
    end

    describe "players" do
      it "returns the list of player types supported by the library" do
        context.players.should == ConfigOptions::HUMAN_READABLE_PLAYERS
      end
    end

    describe "boards" do
      it "returns the list of board types supported by the library" do
        context.boards.should == ConfigOptions::HUMAN_READABLE_BOARDS
      end
    end

    describe "add_game" do
      it "adds a game to the db and returns the id" do
        id = context.add_game(game)
        id.should_not == nil
      end
    end

    describe "create_game" do
      it "create a new game and adds it to the db, returning the id" do
        id = context.create_game(players.first, players.first, boards.first)
        context.get_game(id).should_not == nil
      end
    end

    describe "get_game" do
      it "gets a game from the db and returns the game" do
        game.player1.side = "get_game_test"
        id = context.add_game(game)
        retrieved_game = context.get_game(id)
        retrieved_game.player1.side.should == game.player1.side
      end
    end

    describe "#delete_game" do
      it "removes a game from the db" do
        id = context.add_game(game)
        context.delete_game(id)
        context.get_game(id).should == nil
      end
    end

    describe "#save_game" do
      it "saves a game to the db" do
        id = context.add_game(game)
        added_game = context.get_game(id)
        added_game.board[] = %w(a b c d e f g h i)
        context.save_game(id, added_game)
        saved_game = context.get_game(id)
        added_game.board[].should == saved_game.board[]
      end
    end

    describe "#update_game" do
      before(:each) do
        id = context.add_game(game)
        context.update_game(id, 0, 'x')
        @updated_game = context.get_game(id)
      end

      it "updates a game in the db" do
       @updated_game.board[][0].should == "x"
      end

      it "records move history" do
        @updated_game.history.history.length.should == 1
      end

      it "switches the player" do
        @updated_game.current_player.eql? @updated_game.player2
      end

      it "returns nil if no game is associated with the id" do
        context.update_game(10000000000, 0, 'x').should == nil
      end
    end

    describe "#game_list" do
      it "returns an array of game ids (Strings)" do
        context.game_list.should_not == []
      end
    end

    describe "#ai_move?" do
      it "returns true if the next move is from an AI player" do
        game.player1 = TTT::AIEasy.new(:side => "x")
        game.current_player = game.player1
        id = context.add_game(game)
        context.ai_move?(id).should == true
      end

      it "returns false if the next move is not from an AI player" do
        id = context.add_game(game)
        context.ai_move?(id).should == false
      end

      it "returns nil if the game cannot be found" do
        context.ai_move?(100000000000000).should == nil
      end
    end

    describe "#ai_move" do
      before(:each) do
        game.player1 = AIEasy.new(:side => 'x')
        game.current_player = game.player1
        id = context.add_game(game)
        @updated_game = context.ai_move(id)
      end

      it "gets an updated game with the board containing the ai move" do
        @updated_game.board.empty?.should_not == true
      end

      it "advances current player to the next player" do
        @updated_game.current_player.eql? game.player2
      end

      it "records the game history for the ai move" do
        @updated_game.history.history.length.should == 1
      end
    end

    describe "#finished?" do
      it "returns true if the game is over" do
        game.board[] = %w(a b c d e f g h i)
        id = context.add_game(game)
        context.finished?(id).should == true
      end

      it "returns false if the game is not over" do
        game.board[] = Array.new(9, " ")
        id = context.add_game(game)
        context.finished?(id).should == false
      end

      it "returns nil if the game is not found" do
        context.finished?(100000000).should == nil
      end
    end

    describe "#winner?" do
      it "returns true if a winner is found" do
        game.board[] = %w(x x x x x x x x x)
        id = context.add_game(game)
        context.winner?(id).should == true
      end

      it "returns false if a winner is not found" do
        game.board[] = Array.new(9, " ")
        id = context.add_game(game)
        context.winner?(id).should == false
      end

      it "returns nil if no game exists for the provided id" do
        context.winner?(100000000).should == nil
      end
    end

    describe "#winner" do
      it "returns the winner as a string: 'Player 1' or 'Player 2'" do
        game.board[] = %w(x x x x x x x x x)
        game.switch_player
        id = context.add_game(game)
        context.winner(id).should == "Player 1"
      end

      it "returns nil if no game exists for the provided id" do
        context.winner?(10000000000000).should == nil
      end
    end

    describe "#draw?" do
      it "returns true if the game is a draw" do
        game.board[] = %w(a b c d e f g h i)
        id = context.add_game(game)
        context.draw?(id).should == true
      end

      it "returns false if the game is not a draw" do
        game.board[] = Array.new(9, " ")
        id = context.add_game(game)
        context.draw?(id).should == false
      end

      it "returns false if the game has a winner" do
        game.board[] = %w(x x x x x x x x x)
        id = context.add_game(game)
        context.draw?(id).should == false
      end

      it "returns nil if there is no game for that id" do
        context.draw?(1000000000).should == nil
      end
    end

    describe "#which_board" do
      it "returns `three_by_three` when the board type is 3x3" do
        id = context.add_game(game)
        context.which_board(id).should == "three_by_three"
      end

      it "returns `four_by_four` when the board type is 4x4" do
        game.board = FourByFour.new
        id = context.add_game(game)
        context.which_board(id).should == "four_by_four"
      end

      it "returns `three_by_three_by_three` when the board type is 3x3x3" do
        game.board = ThreeByThreeByThree.new
        id = context.add_game(game)
        context.which_board(id).should == "three_by_three_by_three"
      end

      it "returns nil if there is no game associated with the id" do
        context.which_board(10000000000).should == nil
      end
    end

    describe "#valid_move?" do
      it "returns true if the move input by the user is a valid move for the current game board" do
        id   = context.add_game(game)
        move = 0
        context.valid_move?(id, move).should == true
      end

      it "returns false if the move input by the user is not a valid move for the current game board" do
        game.board[] = %w(x x x x x x x x x)
        id   = context.add_game(game)
        move = 0
        context.valid_move?(id, move).should == false
      end

      it "returns nil if there is no game associated with the id" do
        context.valid_move?(100000000000000, 0).should == nil
      end
    end

    describe "#show_history" do
      it "returns an array of move_history objects for the current game" do
        id = context.add_game(game)
        context.update_game(id, 0, 'x')
        context.update_game(id, 1, 'o')
        context.get_history(id).length.should == 2
      end

      it "returns an empty array when no move has occurred" do
        id = context.add_game(game)
        context.get_history(id).should == []
      end

      it "returns nil if the game associated with the id doesn't exist" do
        context.get_history(100000000000).should == nil
      end
    end

    describe "#which_current_player?" do
      it "returns a string of the current player" do
        id = context.add_game(game)
        context.which_current_player?(id).should == "Player 1"
      end

      it "returns nil if the game associated with the id doesn't exist" do
        context.which_current_player?(100000000000000).should == nil
      end
    end

    describe "#board_arr" do
      it "returns the board array" do
        id = context.add_game(game)
        context.board(id).should == Array.new(9, " ")
      end

      it "returns nil if the game associated with an id doesn't exist" do
        context.board(10000000000).should == nil
      end
    end
  end
end
