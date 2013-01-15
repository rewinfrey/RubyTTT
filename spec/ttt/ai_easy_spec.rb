require 'spec_helper'

module TTT
  describe AIEasy do
    let(:ai)    { AIEasy.new(side: "x") }
    let(:board) { ThreeByThree.new }

    describe "#minimax" do
      it "returns a random available move from the game board" do
        board[] = ["x", "o", " ", " ", " ", " ", "o", "x", "o" ]
        [2, 3, 4, 5].include? ai.move(board: board)
      end
    end
  end
end
