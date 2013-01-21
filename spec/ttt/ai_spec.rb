require 'spec_helper'

module TTT
  describe AI do

    let(:ai)      { AI.new(side: "x") }
    let(:board)   { ThreeByThree.new }

    describe "#move" do
      it "responds to message(:move)" do
        ai.should respond_to(:move)
      end
    end

    describe "#available_moves" do
      it "returns an array of available moves" do
        ai.board = board
        ai.available_moves.should == [0,1,2,3,4,5,6,7,8]
      end

      it "returns [] when no available moves are found" do
        board[] = ["o", "x", "o", "x", "o", "x", "o", "x", "o"]
        ai.board = board
        ai.available_moves.should == []
      end
    end

    describe "#undo_move" do
      it "should revert the original game board back to its previous state" do
        index = 3
        ai.board = board
        ai.board[][3] = "x"
        ai.undo_move(index)
        ai.board[][3].should == " "
      end
    end

    describe "#no_gui?" do
      it "returns true" do
        ai.no_gui?.should == true
      end
    end

    describe "#prompt" do
      it "returns 'Computer thinking'" do
        ai.prompt.should == "Computer thinking."
      end
    end
  end
end
