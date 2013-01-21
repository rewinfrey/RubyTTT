require 'spec_helper'
require 'ttt/config_options'

module TTT
  describe ConfigHelper do
    describe "#self.player_types" do
      it { described_class.player_types.should == ConfigOptions::HUMAN_READABLE_PLAYERS }
    end

    describe "#self.board_types" do
      it { described_class.board_types.should == ConfigOptions::HUMAN_READABLE_BOARDS }
    end

    describe "#self.bucket" do
      it { described_class.bucket.should == ConfigOptions::BUCKET }
    end

    describe "#self.port" do
      it { described_class.port.should == ConfigOptions::PORT }
    end

    describe "#self.http_backend" do
      it { described_class.http_backend.should == ConfigOptions::HTTP_BACKEND }
    end

    describe "#self.get_player_const" do
      it { described_class.get_player_const("Human").should == Human }
    end

    describe "#self.get_board_const" do
      it { described_class.get_board_const("3x3").should == ThreeByThree }
    end

    describe "#self.get_player_index" do
      it { described_class.get_player_index("Human").should == ConfigOptions::HUMAN_READABLE_PLAYERS.index("Human") }
    end

    describe "#self.get_board_index" do
      it { described_class.get_board_index("3x3").should == ConfigOptions::HUMAN_READABLE_BOARDS.index("3x3") }
    end

    describe "#self.get_db_const" do
      it { described_class.get_db_const.should == ConfigOptions::DB }
    end

    describe "#self.get_history_const" do
      it { described_class.get_history_const.should == ConfigOptions::HISTORY }
    end

    describe "#self.get_game_interactor_const" do
      it { described_class.get_game_interactor_const.should == ConfigOptions::INTERACTOR }
    end
  end
end
