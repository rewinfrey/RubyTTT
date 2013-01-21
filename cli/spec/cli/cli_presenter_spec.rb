require 'spec_helper'

module CLI
  describe CLIPresenter do
    let(:instream)  { StringIO.new }
    let(:outstream) { StringIO.new }
    let(:presenter) { Presenter.new(instream, outstream) }

    describe "#new" do
      it "returns a new presenter object" do
        presenter.should_not be_nil
      end
    end

    describe "#output" do
      it "sends an output message to the io" do
        presenter.output "hello"
        presenter.io.outstream.include? "Hello"
      end
    end

    describe "#welcome_prompt" do
      it "displays 'Welcome to TTT!'" do
        presenter.welcome_prompt
        presenter.io.outstream.include? "Welcome to TTT!"
      end
    end

    describe "#command_list" do
      it "sends a command list message to the io" do
        presenter.io.should_receive(:output).at_least(4).times
        presenter.command_list
        presenter.io.outstream.include? "Please select an option from the following list:"
      end
    end

    describe "#menu" do
      it "sends a welcome prompt message to the io" do
        presenter.io.outstream.include? "Welcome to TTT!"
        presenter.io.outstream.include? "1. Play ttt!"
      end
    end

    describe "#input" do
      it "receives input from the command line" do
        presenter.io.instream = StringIO.new("Hello\n")
        presenter.input.chomp.should == "Hello"
      end
    end

    describe "#game_list" do
      it "sends an output message to the io" do
        list = %w(5 3 2 1 4)
        presenter.io.should_receive(:output).at_least(5).times
        presenter.game_list(list)
        presenter.io.outstream.string.should == "5\n4\n3\n2\n1\n"
      end
    end

    describe "#sort_list" do
      it "sorts an array of game id strings into integers" do
        ary = %w(5 4 3 2 1)
        presenter.sort_list(ary).should == %w(1 2 3 4 5)
      end
    end

    describe "#no_games" do
      it "displays 'No games were found.' to the user" do
        presenter.no_games
        presenter.io.outstream.include? "No games were found"
      end
    end

    describe "#player_prompt" do
      it "displays the prompt for the player type" do
        player = double('player')
        player.stub(:prompt).and_return("Entere move:")
        presenter.player_prompt(player)
        presenter.io.outstream.include? "Enter move:"
      end
    end
  end
end
