require 'spec_helper'

module CLI
  describe PlayAgain do
    let(:presenter) { CLIPresenter.new(StringIO.new, StringIO.new) }
    let(:againio)   { PlayAgain.new(presenter) }

    describe "#valid_reply?" do
      it "returns nil if the play again response is not 'y' or 'n'" do
        againio.valid_reply?("1\n").should == nil
      end

      it "returns zero if the play again response is 'y' or 'n'" do
        againio.valid_reply?("n\n").should == 0
        againio.valid_reply?("y\n").should == 0
      end
    end

    describe "#play_again_msg" do
      it "sends a play_again_msg message to gameio" do
        againio.presenter.should_receive(:play_again_msg)
        againio.play_again_msg
      end
    end

    describe "#play_again?" do
      it "prompts the user to play again" do
        againio.presenter.io.instream = StringIO.new("n\n")
        againio.presenter.io.outstream.string.split("\n").include? "Play again (y or n)?"
      end

      it "prompts the user to re-enter input when invalid input is received" do
        againio.presenter.io.instream = StringIO.new("i\nn\n")
        againio.play_again?
        againio.presenter.io.outstream.string.split("\n").include? "I'm sorry, I didn't understand you. Please try again."
      end
    end
  end
end
