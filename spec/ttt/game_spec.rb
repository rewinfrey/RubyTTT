require 'spec_helper'
require 'stringio'

module TTT
  describe Game do
    let(:setup)     { Setup.new }
    let(:players)   { setup.players }
    let(:boards)    { setup.boards  }
    let(:game)      { setup.new_game(player1: players.first, player2: players.first, board: boards.first) }

    describe "#initialize" do
      it "instantiated with a player1" do
        game.player1.should_not == nil
      end

      it "instantiaed with a player1 with side 'x'" do
        game.player1.side.should == "x"
      end

      it "instantiated with a player2" do
        game.player2.should_not == nil
      end

      it "instantiated with a player2 with side 'o'" do
        game.player2.side.should == "o"
      end

      it "has an empty board" do
        game.board.should be_empty
      end
    end

   describe "#current_player" do
      it "is player1 at the beginning of a game" do
        game.current_player.eql? game.player1
      end

      it "is player2 on the next turn" do
        game.switch_player
        game.current_player.eql? game.player2
      end
   end

    describe "#mark_move" do
      it "marks a move on the game board" do
        game.mark_move(1)
        game.board[].should == [" ", "x", " ", " ", " ", " ", " ", " ", " "]
      end
    end

    describe "#switch_player" do
      it "switches current player to the opposite player" do
        game.switch_player
        game.current_player.eql? game.player2
        game.switch_player
        game.current_player.eql? game.player1
      end
    end

    describe "#next_move" do
      before(:each) do
        game.player1        = AIEasy.new(side: "x")
        game.current_player = game.player1
      end

      it "prompts the AI to move next if the AI is the current player" do
        game.player1.should_receive(:move).and_return(0)
        game.next_move
      end

      it "returns an updated board reflecting the AI's move" do
        game.player1.should_receive(:move).and_return(0)
        game.next_move
        game.board[].should == ["x", " ", " ", " ", " ", " ", " ", " ", " "]
      end
    end

    describe "#record_move" do
      it "invokes record_move on history" do
        game.history.should_receive(:record_move)
        game.record_move(0)
      end
    end

    describe "#show_history" do
      it "invokes show on history" do
        game.history.should_receive(:show)
        game.show_history
      end
    end

    describe "#which_board?" do
      it "returns `three_by_three` when the board type is 3x3" do
        game.board = ThreeByThree.new
        game.which_board.should == "three_by_three"
      end

      it "returns `four_by_four` when the board type is 4x4" do
        game.board = FourByFour.new
        game.which_board.should == "four_by_four"
      end

      it "returns `three_by_three_by_three` when the board type is 3x3x3" do
        game.board = ThreeByThreeByThree.new
        game.which_board.should == "three_by_three_by_three"
      end
    end

    describe "#which_current_player" do
      it "returns the current player" do
        game.which_current_player?.should == "Player 1"
        game.which_current_player?.should_not == "Player 2"
      end
    end

    describe "#last_player?" do
      it "returns the previous player" do
        game.last_player?.should == "Player 2"
        game.last_player?.should_not == "Player 1"
      end
    end

    describe "#finished?" do
      it "returns true if the game board is finished" do
        game.board[] = Array.new(9, 'a')
        game.finished?.should == true
      end

      it "returns false if the game board is not finished" do
        game.finished?.should == false
      end
    end

    describe "#not_finished?" do
      it "returns true if the game board is not finished" do
        game.not_finished?.should == true
      end

      it "returns false if the game board is finished" do
        game.board[] = Array.new(9, 'a')
        game.not_finished?.should == false
      end
    end

    describe "#winner?" do
      it "returns true if the game board has a winner" do
        game.board[] = Array.new(9, 'x')
        game.winner?.should == true
      end

      it "returns false if the game board does not have a winner" do
        game.board[] = Array.new(9, ' ')
        game.winner?.should == false
      end
    end

    describe "#draw?" do
      it "returns true if the game board has a draw" do
        game.board[] = %w(a b c d e f g h i)
        game.draw?.should == true
      end

      it "returns false if the game board does not have a draw" do
        game.board[] = Array.new(9, ' ')
        game.draw?.should == false
      end
    end

    describe "#board_arr" do
      it "returns the board array of the current game instance" do
        game.board_arr.class.should == Array
        game.board[] = Array.new(9, 'a')
        game.board_arr.should == Array.new(9, 'a')
      end
    end
  end
end
