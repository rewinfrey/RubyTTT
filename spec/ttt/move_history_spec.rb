require 'spec_helper'

module TTT
  describe MoveHistory do
    describe "#new" do
      it "returns a new TTT::MoveHistory object with side and move attributes" do
        move_history = described_class.new(side: "x", move: 0)
        move_history.side.should == "x"
        move_history.move.should == 0
      end
    end
  end
end
