require 'spec_helper'

module CLI
  describe WalkHistory do
    let(:setup)          { TTT::Setup.new }
    let(:move_history)   { [TTT::MoveHistory.new(:side => 'x', :move => '0'), TTT::MoveHistory.new(:side => 'o', :move => '1'), TTT::MoveHistory.new(:side => 'x', :move => '4'), TTT::MoveHistory.new(:side => 'o', :move => '5'), TTT::MoveHistory.new(:side => 'x', :move => '8') ] }
    let(:game)           { setup.new_game(:player1 => setup.players.first, :player2 => setup.players.first, :board => setup.boards.first) }
    let(:presenter)      { CLIPresenter.new(StringIO.new, StringIO.new) }
    let(:walkio)         { WalkHistory.new(presenter, game) }

    before(:each) do
      game.record_move(0, 'x')
      game.mark_move(0, 'x')
      game.record_move(1, 'o')
      game.mark_move(1, 'o')
      game.record_move(4, 'x')
      game.mark_move(4, 'x')
      game.record_move(5, 'o')
      game.mark_move(5, 'o')
      game.record_move(8, 'x')
      game.mark_move(8, 'x')
    end

    describe "#build_board" do
      it "returns a board array representing the game board at move index 0" do
        walkio.build_board(game.board, 0).should == Array.new(9, ' ')
      end

      it "returns a board array representing the game board at move index 1" do
        walkio.build_board(game.board, 1).should == ['x', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      end

      it "returns a board array representing the game board at move index 2" do
        walkio.build_board(game.board, 2).should == ['x', 'o', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      end

      it "returns a board array representing the game board at move index 3" do
        walkio.build_board(game.board, 3).should == ['x', 'o', ' ', ' ', 'x', ' ', ' ', ' ', ' ']
      end

      it "returns a board array representing the game board at move index 4" do
        walkio.build_board(game.board, 4).should == ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', ' ']
      end

      it "returns a board array representing the game board at move index 5" do
        walkio.build_board(game.board, 5).should == ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', 'x']
      end
    end

    describe "#post_game_msg" do
      it "prompts the user if they 'Would like to review the game history'?" do
        walkio.stub(:process => nil)
        walkio.presenter.stub(:input => 'n\n')
        walkio.presenter.should_receive(:post_game_msg)
        walkio.post_game_msg
      end
    end

    describe "#process" do
      it "does nothing if the user inputs 'n' or 'N'" do
        walkio.process('n').should == nil
        walkio.process('N').should == nil
      end

      it "does presents the user with the `walk_msg` prompt if the user input 'y' or 'Y'" do
        walkio.should_receive(:walk_msg)
        walkio.process('y\n')
      end

      it "gives the user an error message if they input invalid characters" do
        walkio.process('1092093019823\n')
        walkio.presenter.io.outstream.include? "error"
      end
    end

    describe "#walk_msg" do
      it "prompts the user to enter 1, 0 or -1 to walk forward, exit or go backward in the game history" do
        walkio.presenter.stub(:input => '0')
        walkio.walk_msg
        walkio.presenter.io.outstream.include? "Enter -1 to go back, 0 for main menu, or 1 to go forward"
      end
    end

    describe "#walk_history" do
      before(:each) do
        walkio.stub(:walk_msg => nil)
      end
      it "outputs the final board state when asked for a move index greater than the last move made index" do
        final_board = walkio.game.board[]
        walkio.walk_history(1)
        walkio.presenter.io.outstream.include? final_board
      end

      it "returns a virgin board state when asked for a move index less than the first move made index" do
        first_board = Array.new(9, " ")
        walkio.walk_history(-100)
        walkio.presenter.io.outstream.include? first_board
      end

      it "returns board at move index four when asked for the next move index (current move index is 3)" do
        expected_board = ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', ' ']
        walkio.move_traverser.move_index = 3
        walkio.walk_history(1)
        walkio.presenter.io.outstream.include? expected_board
      end

      it "returns board at move index three when asked for the previous move index (current move index is 4)" do
        expected_board = ['x', 'o', ' ', ' ', 'x', ' ', ' ', ' ', ' ']
        walkio.move_traverser.move_index = 4
        walkio.walk_history(-1)
        walkio.presenter.io.outstream.include? expected_board
      end
    end
  end
end
