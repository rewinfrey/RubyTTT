require 'spec_helper'
require 'stringio'
require 'ttt/context'

module CLI
  describe CLIGame do
    let(:setup)       { TTT::Setup.new }
    let(:context)     { TTT::Context.instance }
    let(:players)     { setup.players }
    let(:boards)      { setup.boards }
    let(:db)          { setup.new_db }
    let(:presenter)   { CLIPresenter.new(input, output) }
    let(:output)      { StringIO.new }
    let(:input1)       { StringIO.new("1\n1\n1\n0\n3\n1\n4\n2\nn\n") }
    let(:input)       { StringIO.new }
    let(:game)        { setup.new_game(player1: players.first, player2: players.first, board: boards.first) }
    let(:ai_game)     { setup.new_game(player1: players.last,  player2: players.last,  board: boards.first) }

    before(:each) do
      context.setup = TTT::Setup
      described_class.configure(context, input, output)
    end

    describe "#play" do
      it "displays the main game menu to the user" do
        described_class.instance_variable_get(:@presenter).menu
        described_class.instance_variable_get(:@presenter).io.outstream.include? "Welcome to TTT!"
      end

      it "sets the presenter" do
        described_class.instance_variables.include? @presenter
      end
    end

    describe "#process_command" do
      it "intializes a new game when the user selects 1" do
        described_class.should_receive(:init_game)
        described_class.process_command("1\n")
      end

      it "shows the list of games recorded in the db when the user selects 2" do
        described_class.should_receive(:game_list)
        described_class.process_command("2\n")
      end

      it "exits from the game when the user selects 3" do
        described_class.should_receive(:exit)
        described_class.process_command("3\n")
      end

      it "defaults to showing the main menu again if the user inputs something not recognized" do
        described_class.should_receive(:menu)
        described_class.process_command("78\n")
      end
    end

    describe "#init_game" do
      before(:each) do
        described_class.stub(:get_player_selection => nil)
        described_class.stub(:get_board_selection => nil)
        described_class.stub(:play_game => nil)
        described_class.stub(:build_game => game)
        player_select = PlayerSelection.new(players, @presenter)
        player_select.player1 = players.first
        player_select.player2 = players.first
        context.setup = TTT::Setup
      end

      it "sets up a new game" do
        described_class.instance_variable_get(:@game).player1.eql? game.player1
        described_class.instance_variable_get(:@game).player2.eql? game.player2
        described_class.instance_variable_get(:@game).board.eql? game.board
      end

      xit "displays a player selection prompt" do
        described_class.presenter.instream = StringIO.new("1\n1\n1\n0\n")
        BoardSelection.stub(:process).and_return(nil)
        setup.stub_chain(:new, :new_game).and_return(nil)
        described_class.stub(:play_game).and_return(nil)
        described_class.init_game
        described_class.presenter.outstream.include? "Please select an option for Player 1:"
        described_class.presenter.outstream.include? "Please select an option for Player 2:"
      end

      xit "displays a board selection prompt" do
        described_class.presenter.instream = StringIO.new("1\n1\n1\n")
        TTT::GameBuilder.stub_chain(:new, :new_game).and_return(nil)
        described_class.stub(:play_game).and_return(nil)
        described_class.init_game
        described_class.presenter.outstream.include? "Please select which board you'd like to play:"
      end

      xit "creates a new game" do
        described_class.presenter.io.instream = StringIO.new("1\n1\n1\n1\n0\n1\n3\n4\n6\nn\n")
        described_class.stub(:play_game).and_return(nil)
        described_class.init_game
        described_class.game.should_not be_nil
      end
    end

    describe "#play_game" do
      xit "plays a game until the game is finished" do
        described_class.presenter.instream = StringIO.new("1\n1\n1\n0\n1\n4\n3\n8\nn\n")
        described_class.stub(:play_again).and_return(nil)
        described_class.init_game
        described_class.presenter.outstream.include? "Would you like to play again?"
      end
    end

    describe "#move_cycle" do
      before(:each) do
        described_class.stub(:process_next_move).and_return(nil)
        described_class.move_cycle
      end

      xit "shows a help board so the user knows how to move" do
        described_class.presenter.should_receive(:output_help).with(described_class.game.board[])
        described_class.presenter.stub_chain(:output_board, :player_prompt).and_return(nil)
        described_class.move_cycle
      end

      xit "shows the current game board" do
        described_class.presenter.should_receive(:output_board).with(described_class.game.board[])
        described_class.presenter.stub(:player_prompt).and_return(nil)
        described_class.move_cycle
      end

      xit "shows a prompt for the current player" do
        described_class.presenter.should_receive(:player_prompt).with(described_class.game.current_player)
        described_class.move_cycle
      end
    end

    describe "#process_next_move" do
      xit "calls TTT::Game#next_move if the current_player is an AI player" do
        described_class.game = ai_game
        described_class.game.should_receive(:next_move).and_return(0)
        described_class.process_next_move
      end

      xit "asks waits for input if the current_player is not an AI player" do
        described_class.game = game
        described_class.presenter.instream = StringIO.new("1\n")
        described_class.should_receive(:process_human_move).with("1\n")
        described_class.process_next_move
      end
    end

    describe "#process_human_move" do
      xit "marks the human move on the game board" do
        described_class.game.should_receive(:mark_move).with(1)
        described_class.process_human_move("1")
      end

      xit "records the human move in the game history" do
        described_class.game.should_receive(:record_move).with(1)
        described_class.process_human_move("1")
      end
    end

    describe "#game=" do
      xit "sets a new game object to the described class's game var" do
        described_class.game = nil
        described_class.game.should == nil
      end
    end

    describe "#game" do
      xit "returns the current game object for the described class" do
        described_class.game = nil
        described_class.game.should be_nil
      end
    end

    describe "#presenter" do
      xit "returns the current presenter object for the described class" do
        described_class.presenter = nil
        described_class.presenter.should be_nil
      end
    end

    describe "#presenter=" do
      xit "sets the current presenter object for the described class with the arg provided it" do
        described_class.presenter = nil
        described_class.presenter.should be_nil
      end
    end

    describe "#eval_board_state" do
      before(:each) do
        described_class.game = game
        described_class.presenter = View.new(instream: input, outstream: output)
      end

      xit "displays the winner if a winner is present" do
        described_class.game.board[] = %w(x x x x x x x x x)
        described_class.game.current_player = described_class.game.player2
        described_class.presenter.should_receive(:output_board).with(described_class.game.board[])
        described_class.presenter.should_receive(:winner_prompt).with("Player 1")
        described_class.eval_board_state
      end

      xit "displays the draw prompt if the game results in a draw" do
        described_class.game.board[] = %w(a b c d e f g h i)
        described_class.presenter.should_receive(:output_board).with(described_class.game.board[])
        described_class.presenter.should_receive(:draw_prompt)
        described_class.eval_board_state
        described_class.presenter.outstream.include? "It's a draw"
      end
    end

    describe "#play_again" do
      before(:each) do
        described_class.game = game
        described_class.presenter = View.new(instream: input, outstream: output)
      end

      xit "prompts the user to play again at the end of a game" do
        described_class.presenter.instream = StringIO.new("y\n")
        described_class.presenter.outstream.include? "Do you want to play again?"
      end

      xit "exits if the user does not want to play again" do
        described_class.presenter.instream = StringIO.new("n\n")
        described_class.should_not_receive(:play)
      end
    end
  end
end
