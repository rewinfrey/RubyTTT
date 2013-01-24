require 'spec_helper'
require 'playscripts/game_playscript'
require 'rubygems'
require 'ttt/context'
require 'ttt/setup'

describe "GamePlayscript" do
  let(:context) { TTT::Context.instance }

  before(:each) do
    context.setup = TTT::Setup
    players    = context.players
    boards     = context.boards
    ai_game_id = context.create_game(players[1], players[1], boards[0])
    game_id    = context.create_game(players[0], players[0], boards[0])
    production = stub(:context => context)
    @ai_game_ps   = GamePlayscript.new(:context => context, :game_id => ai_game_id, :production => production)
    @game_ps      = GamePlayscript.new(:context => context, :game_id => game_id, :production => production)
    @game         = @game_ps.context.get_game(@game_ps.game_id)
    @ai_game      = @ai_game_ps.context.get_game(@ai_game_ps.game_id)
    @game_id      = @game_ps.game_id
    @ai_id        = @ai_game_ps.game_id
  end

  def save_game(id, game)
    context.save_game(id, game)
  end

  describe "#set_move" do
    before(:each) do
      @mock_move = double('move')
    end

    it "sets the player's move from a board square for squares 0 - 8" do
      @mock_move.should_receive(:id).and_return("square1")
      @game_ps.set_move(@mock_move)
      @game_ps.move.should == 1
    end

    it "sets the player's move from a board square for squares 9 - 26" do
      @mock_move.should_receive(:id).and_return("square22")
      @game_ps.set_move(@mock_move)
      @game_ps.move.should == 22
    end
  end

  describe "#which_current_player?" do
    it "returns 'Player 1' when it's player1's turn" do
      @game_ps.which_current_player?.should == "Player 1"
    end

    it "returns 'Player 2' when it's player2's turn" do
      @game.current_player = @game.player2
      save_game(@game_id, @game)
      @game_ps.which_current_player?.should == "Player 2"
    end
  end

  describe "#finished?" do
    it "returns true when the game board is full" do
      @game.board.board = %w(a b c d e f g h i)
      save_game(@game_id, @game)
      @game_ps.finished?.should == true
    end

    it "returns false when the game board contains a blank space (means free square)" do
      @game.board.board = Array.new(9, " ")
      save_game(@game_id, @game)
      @game_ps.finished?.should == false
    end
  end

  describe "#not_finished?" do
    it "returns true when the game is not finished" do
      @game_ps.not_finished?.should == true
    end

    it "returns false when the game is finished" do
      @game.board.board = [0,1,2,3,4,5,6,7,8]
      save_game(@game_id, @game)
      @game_ps.not_finished?.should == false
    end
  end

  describe "#finished" do
    it "returns true when the game is over" do
      @game.board.board = ['x', 'o', 'x', 'o', 'x', 'o', 'x', 'o', 'x', 'o']
      save_game(@game_id, @game)
      @game_ps.finished?.should == true
    end

    it "returns false when the game isn't over yet" do
      @game_ps.finished?.should == false
    end
  end

  describe "#winner" do
    before(:each) do
      @game.board.board = ['x', 'x', 'x', '', '', '', '', '', '']
      save_game(@game_id, @game)
    end

    it "displays `Player 1 is the winner` when player 1 wins" do
      @game.current_player = @game.player2
      save_game(@game_id, @game)
      @game_ps.winner.should == "Player 1"
   end

    it "displays `Player 2 is the winner` when player 2 wins" do
      @game_ps.winner.should == "Player 2"
    end
  end


  describe "#winner?" do
    it "returns true when the game has a winner" do
      @game.board.board = ['x', 'x', 'x', '', '', '', '', '', '']
      save_game(@game_id, @game)
      @game_ps.winner?.should == true
    end

    it "returns false when the game does not have a winner" do
      @game.board.board = ['y', 't', 'z', 'c', 'h', 'g', 'c', 'p', 'q']
      save_game(@game_id, @game)
      @game_ps.winner?.should == false
    end
  end

  describe "#valid_move?" do
    before(:each) do
      @mock_move = double('move')
      @mock_move.should_receive(:id).and_return("square1")
    end

    it "returns true when the move is valid" do
      @game_ps.set_move(@mock_move)
      @game_ps.valid_move?.should == true
    end

    it "returns flase when the move is invalid" do
      @game.board.board = %w(a b c d e f g h i)
      save_game(@game_id, @game)
      @game_ps.set_move(@mock_move)
      @game_ps.valid_move?.should == false
    end
  end

  describe "#next_move_is_ai?" do
    it "returns true when current player is an ai player" do
      @ai_game_ps.next_move_is_ai?.should == true
    end

    it "returns false when the curent player is a human player" do
      @game_ps.next_move_is_ai?.should == false
    end
  end

  describe "#board" do
    it "requests the board array from the game" do
      @game_ps.board.should == @game.board.board
    end
  end

  describe "#mark_move" do
    it "sends a mark_move message to the game" do
      @game_ps.should_receive(:move).and_return(1)
      @game_ps.context.should_receive(:update_game).with(@game_id, 1, 'x')
      @game_ps.mark_move
    end
  end

  describe "#ai_move" do
    it "sends a next_move message to the game indicating it's the computer player's turn" do
      @game_ps.context.should_receive(:ai_move).with(@game_id)
      @game_ps.ai_move
    end
  end

  describe "#which_board" do
    it "returns 'three_by_three' when it's a 3x3 board" do
      @game_ps.which_board?.should == "three_by_three"
    end

    it "returns 'four_by_four' when it's a 4x4 board" do
      @game.board = TTT::FourByFour.new
      save_game(@game_id, @game)
      @game_ps.which_board?.should == "four_by_four"
    end

    it "returns 'three_by_three_by_three' when it's a 3x3x3 board" do
      @game.board = TTT::ThreeByThreeByThree.new
      save_game(@game_id, @game)
      @game_ps.which_board?.should == "three_by_three_by_three"
    end
  end

  context "user wants to move through a previously played game's move history" do
    before(:each) do
      @game.record_move(0, 'x')
      @game.mark_move(0, 'x')
      @game.record_move(1, 'o')
      @game.mark_move(1, 'o')
      @game.record_move(4, 'x')
      @game.mark_move(4, 'x')
      @game.record_move(2, 'o')
      @game.mark_move(2, 'o')
      @game.record_move(8, 'x')
      @game.mark_move(8, 'x')
      save_game(@game_id, @game)
    end

    describe "#game_move_index" do
      it "gets the number of moves made for a completed game" do
        @game_ps.game_move_index.should == 5
      end
    end
  end
end
