require 'spec_helper'

module TTT
  describe AIMedium do
    let(:ai)    { AIMedium.new(side: "o") }
    let(:board) { ThreeByThree.new }

    describe "#minimax" do
      it "blocks a potential fork win" do
        #situation: x to move
        #     o  |     |  x
        #   -----------------
        #        |  o  | block
        #   -----------------
        #        |     |  x
        board[] = ['o', ' ', 'x', ' ', 'o', ' ', ' ', ' ', 'x']
        ai.move(board: board)
        ai.minimax.should == 5
      end

      it "takes a winning move when one is immediately avaialable" do
        #situation: o to move
        #    o  |  o  | win
        #   ---------------
        #    x  |  x  |
        #   ---------------
        #       |     |
        board[] = ['o', 'o', ' ', 'x', 'x', ' ', ' ', ' ', ' ']
        ai.move(board: board)
        ai.minimax.should == 2
      end

      it "blocks an opponnent's winning move when one is found" do
        #situation: o to move
        #    x  |  x  | block
        #   ---------------
        #    o  |     |
        #   ---------------
        #    o  |     |
        board[] = ['x', 'x', ' ', 'o', ' ', ' ', 'o', ' ', ' ']
        ai.move(board: board)
        ai.minimax.should == 2
      end

      it "returns 0 when it's a draw" do
        board[] = ['x', 'o', 'o', 'o', 'x', 'x', 'o', 'x', 'o']
        ai.move(board: board).should == 0
      end
    end

    describe "#set_max_ply" do
      it "returns 3 when number of available moves > 15" do
        ai.set_max_ply(16).should == 3
      end

      it "returns 5 when number of available moves > 5 && < 15" do
        ai.set_max_ply(14).should == 5
      end

      it "returns 7 when the number of available moves < 5" do
        ai.set_max_ply(3).should == 7
      end
    end
  end
end
