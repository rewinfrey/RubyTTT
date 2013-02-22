require 'spec_helper'

module CLI
  describe BoardSelection do
    let(:view)       { CLIO.new(StringIO.new, StringIO.new) }
    let(:boards)     { TTT::Setup.new.players }
    let(:presenter)  { CLIPresenter.new(StringIO.new, StringIO.new) }
    let(:boardio)    { BoardSelection.new(boards, presenter) }

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
        presenter.io.instream = StringIO.new("9\n1\n")
        boardio.process
      end
    end
  end
end
