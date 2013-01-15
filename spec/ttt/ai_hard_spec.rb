require 'spec_helper'

module TTT
  describe AIHard do
    let(:ai)    { AIHard.new(side: "o") }
    let(:board) { ThreeByThree.new }

    describe "#minimax" do
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

      it "it prevents forking" do
        #situation: o to move
        #    x  |  o  |
        #   ---------------
        #    o  |     | x
        #   ---------------
        #       |  x  | best
        board[] = ['x', 'o', ' ', 'o', ' ', 'x', ' ', 'x', ' ']
        ai.move(board: board)
        ai.minimax.should == 8
      end
    end

    it "finds the best opening move on small games" do
      board[] = Array.new(9, " ")
      ai.move(board: board)
      ai.minimax.should == 4
    end

    describe "#alpha_beta_swapped?" do
      it "returns true when alpha >= beta" do
        ai.alpha_beta_swapped?(500, 500).should == true
      end

      it "returns false when alpha < beta" do
        ai.alpha_beta_swapped?(200, 800).should == false
      end
    end

    describe "#max_ply_for" do
      it "returns 7 when available moves > 16" do
        ai.max_ply_for(17).should == 7
      end

      it "returns 9 when available moves <= 16 and > 10" do
        ai.max_ply_for(12).should == 9
      end

      it "returns 11 when available moves <= 10" do
        ai.max_ply_for(7).should == 11
      end
    end
  end
end
