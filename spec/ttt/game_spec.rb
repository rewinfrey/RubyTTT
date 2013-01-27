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
        game.last_player.should == "Player 2"
        game.last_player.should_not == "Player 1"
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

    describe "#adjust_move_index" do
      it "adjusts the game_history#move_traverser move_index" do
        game.record_move(1, 'x')
        game.history.move_traverser.move_index.should == 1
        game.adjust_move_index(-1)
        game.history.move_traverser.move_index.should == 0
      end
    end

    describe "#initialize_history" do
      it "resets the game_history to the length of the GameHistory#history array" do
        game.record_move(1, 'x')
        game.history.move_traverser.move_index.should == 1
        game.adjust_move_index(-1)
        game.history.move_traverser.move_index.should == 0
        game.initialize_history
        game.history.move_traverser.move_index.should == 1
      end
    end

    describe "#get_history_board" do
      it "returns the game board at the specified move number" do
        game.record_move(0, 'o')
        game.record_move(1, 'x')
        game.record_move(2, 'x')
        game.record_move(3, 'x')
        game.record_move(4, 'x')
        game.record_move(5, 'o')
        game.record_move(6, 'o')
        game.record_move(7, 'o')
        game.record_move(8, 'o')
        game.get_history_board(1).should == ['o', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        game.get_history_board(2).should == ['o', 'x', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        game.get_history_board(3).should == ['o', 'x', 'x', ' ', ' ', ' ', ' ', ' ', ' ']
        game.get_history_board(4).should == ['o', 'x', 'x', 'x', ' ', ' ', ' ', ' ', ' ']
        game.get_history_board(5).should == ['o', 'x', 'x', 'x', 'x', ' ', ' ', ' ', ' ']
        game.get_history_board(6).should == ['o', 'x', 'x', 'x', 'x', 'o', ' ', ' ', ' ']
        game.get_history_board(7).should == ['o', 'x', 'x', 'x', 'x', 'o', 'o', ' ', ' ']
        game.get_history_board(8).should == ['o', 'x', 'x', 'x', 'x', 'o', 'o', 'o', ' ']
        game.get_history_board(9).should == ['o', 'x', 'x', 'x', 'x', 'o', 'o', 'o', 'o']
      end
    end

    describe "#valid_move" do
      before(:each) do
        game.board.board = ['x', 'o', 'x', 'o', ' ', ' ', ' ', ' ', ' ']
      end

      it "returns true when a move is possible" do
        game.valid_move?(4).should == true
        game.valid_move?(5).should == true
        game.valid_move?(6).should == true
        game.valid_move?(7).should == true
        game.valid_move?(8).should == true
      end

      it "returns false when a move the move's intended square has already been taken" do
        game.valid_move?(0).should == false
        game.valid_move?(1).should == false
        game.valid_move?(2).should == false
        game.valid_move?(3).should == false
      end

      it "returns false when input is not a number within 0 and the board length" do
        game.valid_move?('z').should == false
        game.valid_move?(123.123).should == false
      end
    end
  end
end
