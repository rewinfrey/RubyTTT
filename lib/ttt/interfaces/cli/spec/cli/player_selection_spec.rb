require 'spec_helper'

module CLI
  describe PlayerSelection do
    let(:presenter)    { CLIPresenter.new(StringIO.new, StringIO.new) }
    let(:players) { TTT::Setup.new.players }

    let(:ptypeio) { PlayerSelection.new(players, presenter) }

    describe "#player_selection_valid?" do
      it "returns false if input is not an integer within the range of available options" do
        ptypeio.player_selection_valid?(10).should == false
        ptypeio.player_selection_valid?(6).should == false
      end

      it "returns true if input is an integer within the range of available options" do
        ptypeio.player_selection_valid?(2).should == true
        ptypeio.player_selection_valid?(3).should == true
      end
    end

    describe "#player_type_prompt" do
      it "displays an enumerable list of player types the user can choose from" do
        presenter.player_type_prompt(1, players)
        ptypeio.presenter.io.outstream.string.split('n').include? "1. Human"
        ptypeio.presenter.io.outstream.string.split('n').include? "2. AI Easy"
      end
    end

    describe "#set_player_string" do
      it "sets a player type string representing the class constant in the list of player types" do
        ptypeio.set_player_string(1, 1)
        ptypeio.player1.should == "Human"
        ptypeio.set_player_string(2, 2)
        ptypeio.player2.should == "AI Easy"
      end
    end

    describe "#process_player_type_input" do
      it "when input passes validation, the player type is associated with that player number as a string" do
        ptypeio.process_player_type_input(1, "1\n")
        ptypeio.player1.should == "Human"
      end

      it "when input doesn't pass validation, an error prompt is generated and the user is prompted to input again" do
        ptypeio.presenter.io.instream = StringIO.new("1\n")
        ptypeio.process_player_type_input(1, "6\n")
        ptypeio.presenter.io.outstream.string.split("\n").include? "I'm sorry, I didn't understand. Please try again."
        ptypeio.player1.should == "Human"
      end
    end

    describe "#process" do
      it "prompts the player to enter a type for player1 and player2, resulting in player1 and player2 being set" do
        ptypeio.presenter.io.instream = StringIO.new("1\n1\n")
        ptypeio.process
        ptypeio.player1.should == "Human"
        ptypeio.player2.should == "Human"
      end
    end
  end
end
