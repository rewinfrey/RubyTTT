require 'spec_helper'

module CLI
  describe BoardSelection do
    let(:view)       { View.new(instream: StringIO.new, outstream: StringIO.new) }
    let(:boards)     { TTT::GameBuilder.new.players }
    let(:boardio)    { BoardSelection.new(view: view, boards: boards) }

    describe "#board_selection_input_valid?" do
      it "returns true when input is within valid range of options" do
        boardio.board_selection_input_valid?(1).should == true
        boardio.board_selection_input_valid?(2).should == true
      end

      it "returns false when input is not within valid range of options" do
        boardio.board_selection_input_valid?(6).should == false
        boardio.board_selection_input_valid?(1.5).should == false
      end
    end

    describe "#process" do
      it "displays a generic error message if the user inputs invalid input" do
        boardio.view.instream = StringIO.new("9\n1\n")
        boardio.process
      end
    end
  end
end
