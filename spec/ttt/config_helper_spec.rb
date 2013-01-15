require 'spec_helper'
require 'ttt/configuration'

module TTT
  describe ConfigHelper do
    describe "#self.player_types" do
      it { described_class.player_types.should == HUMAN_READABLE_PLAYERS }
    end

    describe "#self.board_types" do
      it { described_class.board_types.should == HUMAN_READABLE_BOARDS }
    end

    describe "#self.get_player_const" do
      it { described_class.get_player_const("Human").should == TTT::Human }
    end

    describe "#self.get_board_const" do
      it { described_class.get_board_const("3x3").should == TTT::ThreeByThree }
    end

    describe "#self.get_player_index" do
      it { described_class.get_player_index("Human").should == HUMAN_READABLE_PLAYERS.index("Human") }
    end

    describe "#self.get_board_index" do
      it { described_class.get_board_index("3x3").should == HUMAN_READABLE_BOARDS.index("3x3") }
    end
  end
end
