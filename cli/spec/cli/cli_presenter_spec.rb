require 'spec_helper'

module CLI
  describe CLIPresenter do
    let(:instream)  { StringIO.new }
    let(:outstream) { StringIO.new }
    let(:presenter) { CLIPresenter.new(instream, outstream) }

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

    describe "#process_game_list" do
      it "sends an output message to the io" do
        list = %w(5 4 3 2 1)
        presenter.io.outstream = StringIO.new(list.join("\n"))
        presenter.io.instream  = StringIO.new("1\n")
        presenter.io.should_receive(:output).at_least(2)
        presenter.process_game_list(list)
        presenter.io.outstream.string.should == "5\n4\n3\n2\n1"
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
        history = stub(:each_with_index => [])
        board = Array.new(9, ' ')
        player = double('player')
        player.stub(:prompt).and_return("Entere move:")
        presenter.player_prompt(board, history, player)
        presenter.io.outstream.include? "Enter move:"
      end
    end

    describe "#output_three_by_three" do
      it "prints game board" do
        board = Array.new(9, ' ')
        presenter.output_three_by_three(board)
        presenter.io.outstream.string.chomp.should ==      "\n     |     |     \n"+
                                                     "-----------------\n"+
                                                     "     |     |     \n"+
                                                     "-----------------\n"+
                                                     "     |     |     "
      end
    end

    describe "#output_four_by_four" do
      it "displays a four by four board" do
        board = Array.new(16, ' ')
        presenter.output_four_by_four(board)
        presenter.io.outstream.string.chomp.should == "\n     |     |     |     \n"+
                                                "-----------------------\n"+
                                                "     |     |     |     \n"+
                                                "-----------------------\n"+
                                                "     |     |     |     \n"+
                                                "-----------------------\n"+
                                                "     |     |     |      "
      end
    end

    describe "#winner_prompt" do
      it "displays 'Player 1 is the winner!" do
        presenter.winner_prompt("Player 1")
        presenter.io.outstream.string.split("\n").include? "Player 1 is the winner!"
      end
    end

    describe "#draw_prompt" do
      it "displays 'It's a draw!'" do
        presenter.draw_prompt
        presenter.io.outstream.string.split("\n").include? "It's a draw!"
      end
    end

    describe "#four_by_four_move_prompt" do
      it "displays a help menu to indicate how the user can move on a 4x4 board" do
        presenter.four_by_four_move_prompt
        presenter.io.outstream.string.chomp.should == "\n  0  |  1  |  2  |  3  \n"+
                                                "-----------------------\n"+
                                                "  4  |  5  |  6  |  7  \n"+
                                                "-----------------------\n"+
                                                "  8  |  9  | 10  | 11  \n"+
                                                "-----------------------\n"+
                                                " 12  | 13  | 14  | 15   "
      end
    end

    describe "#post_game_msg" do
      it "prompts the user if they 'Would like to review the game history'?" do
        presenter.post_game_msg
        presenter.io.outstream.include? "\nWould you like to review the game history (y or n)?"
      end
    end
  end
end
