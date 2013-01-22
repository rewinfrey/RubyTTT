require 'spec_helper'

module TTT
  describe MoveTraverser do
    let(:board)        { ThreeByThree.new }
    let(:game_history) { GameHistory.new }
    let(:traverser)    { game_history.move_traverser }

    context do
      before(:each) do
        game_history.record_move(0, 'x')
        game_history.record_move(1, 'o')
        game_history.record_move(2, 'x')
        game_history.record_move(3, 'o')
        game_history.record_move(4, 'x')
      end

      describe "#adjust_move_index" do

        it "moves backward in the move history by 1 when its invoked with -1" do
          traverser.adjust_move_index(-1)
          traverser.move_index.should == 4
        end

        it "moves forward in the move history by 1 when its invoked with 1" do
          traverser.move_index = 4
          traverser.adjust_move_index(1)
          traverser.move_index.should == 5
        end

        it "moves backward in the move history by 2 when its invoked with -2" do
          traverser.adjust_move_index(-2)
          traverser.move_index.should == 3
        end

        it "moves forward in the move history by 2 when its invoked with 2" do
          traverser.move_index = 2
          traverser.adjust_move_index(2)
          traverser.move_index.should == 4
        end

        it "cannot move backwards beyond move index 0" do
          traverser.move_index = 0
          traverser.adjust_move_index(-1)
          traverser.move_index.should == 0
        end

        it "cannot move beyond the max length" do
          traverser.move_index = traverser.max_length
          traverser.adjust_move_index(100)
          traverser.move_index.should == traverser.max_length
        end
      end

      describe "#history_board_builder" do
        it "returns a board array representing the moves made up to move_number in history" do
          traverser.history_board_builder(board, 3).should == ['x', 'o', 'x', ' ', ' ', ' ', ' ', ' ', ' ']
          board.board = Array.new(9, ' ')
          traverser.history_board_builder(board, 5).should == ['x', 'o', 'x', 'o', 'x', ' ', ' ', ' ', ' ']
          board.board = Array.new(9, ' ')
          traverser.history_board_builder(board, 0).should == Array.new(9, ' ')
        end

        it "does not alter the original board" do
          traverser.history_board_builder(board, 3).should_not == board.board
        end

        it "does not alter the original game history" do
          original_history = traverser.game_history.history
          traverser.game_history.history.should == original_history
        end
      end
    end
  end
end
