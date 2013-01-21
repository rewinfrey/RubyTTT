require 'spec_helper'

module TTT
  describe Board do
    let(:board)     { ThreeByThree.new }

    describe "#initialize" do
      it "board has length 9" do
        board[].length.should == 9
      end
    end

    describe "#update" do
      it "updates the game board after move is received" do
        board.update(1, "x")
        board[].should == [" ", "x", " ", " ", " ", " ", " ", " ", " "]
      end
    end

    describe "#empty?" do
      it "returns true when board is empty" do
        board.empty?.should == true
      end

      it "returns false when board is not empty" do
        board.update(1, "x")
        board.empty?.should == false
      end
    end

    describe "#full?" do
      it "returns true when board is full" do
        9.times do |n|
          board.update(n, "o")
        end
        board.full?.should == true
      end

      it "returns false when board isn't full" do
        board.update(1, "x")
        board.full?.should == false
      end
    end

    describe "#free?" do
      it "returns false when board is occupied at a given cell" do
        board.update(1, "x")
        board.free?(1).should == false
      end

      it "returns true when board is not occupied at a given cell" do
        board.free?(0).should == true
      end
    end

    describe "#draw_game?" do
      it "returns false when board is not full" do
        board.draw_game?.should == false
      end

      it "returns true when board is full" do
        board[] = ["x", "o", "x", "x", "o", "o", "o", "x", "o"]
        board.draw_game?.should == true
      end
    end

    describe "#winner?" do
      it "returns false when the board has no winner" do
        board.winner?.should == false
      end

      it "returns true when the board has a winner" do
        board[] = ["x", "x", "x", "o", " ", "o", " ", " ", " "]
        board.winner?.should == true
      end
    end

    describe "#finished?" do
      it "returns false when board is not full, no win, or no draw" do
        board.finished?.should == false
      end

      it "returns true when board has a win" do
        board.update(0, 'x')
        board.update(1, 'x')
        board.update(2, 'x')
        board.finished?.should == true
      end

      it "returns true when board has a draw" do
        board[] = ["x", "o", "x", "x", "o", "o", "o", "x", "o"]
        board.finished?.should == true
      end
    end
  end
end
