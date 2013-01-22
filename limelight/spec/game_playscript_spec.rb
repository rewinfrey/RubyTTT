require 'spec_helper'
require 'playscripts/game_playscript'
require 'rubygems'
require 'ttt/context'
require 'ttt/setup'

describe "GamePlayscript" do
  let(:context) { TTT::Context.instance }
  let(:context) { context.setup = TTT::Setup }
  let(:players) { context.players }
  let(:boards)  { context.boards  }
  let(:game)    { context.setup.new_game(:player1 => players[0], :player2 => players[1], :board => boards[0]) }
  let(:ai_game) { context.setup.new_game(:player1 => players[1], :player2 => players[1], :board => boards[0]) }

  let(:scene)   { double('scene', :name => "ttt") }

  let(:limelight) { GamePlayscript.new(:context => scene, :game => game) }

  describe "scene name" do
    it "is three_by_three" do
      scene.name.should == "ttt"
    end
  end

  describe "#context=" do
    it "sets the context (scene)" do
      scene.eql? limelight.context
    end
  end

  describe "#set_move" do
    it "sets the player's move from a board square for squares 0 - 8" do
      mock_move = double('move')
      mock_move.should_receive(:id).and_return("square1")
      limelight.set_move(mock_move)
      limelight.move.should == 1
    end

    it "sets the player's move from a board square for squares 9 - 26" do
      mock_move = double('move')
      mock_move.should_receive(:id).and_return("square22")
      limelight.set_move(mock_move)
      limelight.move.should == 22
    end
  end

  describe "#which_current_player?" do
    it "returns 'Player 1' when it's player1's turn" do
      limelight.which_current_player?.should == "Player 1"
    end

    it "returns 'Player 2' when it's player2's turn" do
      limelight.game.current_player = limelight.game.player2
      limelight.which_current_player?.should == "Player 2"
    end
  end

  describe "#finished?" do
    it "returns true when the game board is full" do
      limelight.game.board[] = Array.new(8, 'x')
      limelight.finished?.should == true
    end

    it "returns false when the game board contains a blank space (means free square)" do
      limelight.game.board[] = Array.new(8, " ")
      limelight.finished?.should == false
    end
  end

  describe "#not_finished?" do
    it "returns true when the game is not finished" do
      limelight.not_finished?.should == true
    end

    it "returns false when the game is finished" do
      limelight.game.board[] = [0,1,2,3,4,5,6,7,8]
      limelight.not_finished?.should == false
    end
  end

  describe "#finished" do
    it "returns true when the game is over" do
      limelight.game.board[] = ['x', 'o', 'x', 'o', 'x', 'o', 'x', 'o', 'x', 'o']
      limelight.finished?.should == true
    end

    it "returns false when the game isn't over yet" do
      limelight.finished?.should == false
    end
  end

  describe "#winner" do
    before(:each) do
      limelight.game.board[] = ['x', 'x', 'x', '', '', '', '', '', '']
    end

    it "displays `Player 1 is the winner` when player 1 wins" do
      limelight.game.current_player = limelight.game.player2
      limelight.winner.should == "Player 1 is the winner"
   end

    it "displays `Player 2 is the winner` when player 2 wins" do
      limelight.game.current_player = limelight.game.player1
      limelight.winner.should == "Player 2 is the winner"
    end
  end


  describe "#winner?" do
    it "returns true when the game has a winner" do
      limelight.game.board[] = ['x', 'x', 'x', '', '', '', '', '', '']
      limelight.winner?.should == true
    end

    it "returns false when the game does not have a winner" do
      limelight.game.board[] = ['y', 't', 'z', 'c', 'h', 'g', 'c', 'p', 'q']
      limelight.winner?.should == false
    end
  end

  describe "#valid_move?" do
    it "returns true when the move is valid" do
      mock_move = double('move')
      mock_move.should_receive(:id).and_return("square1")
      limelight.set_move(mock_move)
      limelight.valid_move?.should == true
    end
  end

  describe "#next_move_is_ai?" do
    it "returns true when current player is an ai player" do
      limelight.game = ai_game
      limelight.next_move_is_ai?.should == true
    end

    it "returns false when the curent player is a human player" do
      limelight.next_move_is_ai?.should == false
    end
  end

  describe "#board" do
    it "requests the board array from the game" do
      limelight.game.board[].should == limelight.board
    end
  end

  describe "#switch_player" do
    it "sends a switch_player message to the game" do
      limelight.game.should_receive(:switch_player)
      limelight.switch_player
    end
  end

  describe "#record_move" do
    it "sends a record_move message to the game" do
      limelight.should_receive(:move).and_return(1)
      limelight.game.should_receive(:record_move)
      limelight.record_move
    end
  end

  describe "#mark_move" do
    it "sends a mark_move message to the game" do
      limelight.should_receive(:move).and_return(1)
      limelight.game.should_receive(:mark_move)
      limelight.mark_move
    end
  end

  describe "#ai_move" do
    it "sends a next_move message to the game indicating it's the computer player's turn" do
      limelight.game.should_receive(:next_move)
      limelight.ai_move
    end
  end

  describe "#which_board" do
    it "returns 'three_by_three' when it's a 3x3 board" do
      limelight.which_board?.should == "three_by_three"
    end

    it "returns 'four_by_four' when it's a 4x4 board" do
      limelight.game.board = TTT::FourByFour.new
      limelight.which_board?.should == "four_by_four"
    end

    it "returns 'three_by_three_by_three' when it's a 3x3x3 board" do
      limelight.game.board = TTT::ThreeByThreeByThree.new
      limelight.which_board?.should == "three_by_three_by_three"
    end
  end
end
