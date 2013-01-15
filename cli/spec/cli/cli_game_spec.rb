require 'spec_helper'

module CLI
  describe CLIGame do
    let(:players)     { TTT::GameBuilder.new.players }
    let(:boards)      { TTT::GameBuilder.new.boards  }
    let(:db)          { TTT::GameBuilder.new.new_db(:bucket => "ttt_test_list") }
    let(:output)      { StringIO.new }
    let(:input)       { StringIO.new }
    let(:game)        { TTT::GameBuilder.new.new_game(player1: players.first, player2: players.first, board: boards.first) }
    let(:ai_game)     { TTT::GameBuilder.new.new_game(player1: players.last,  player2: players.last,  board: boards.first) }

    describe "#play" do
      it "sets a view object on the described class" do
        described_class.stub(:menu).and_return(nil)
        described_class.play(players: players, boards: boards, output: output, input: input, db: db)
        described_class.view.should_not be_nil
        described_class.view.should respond_to(:outstream)
        described_class.view.should respond_to(:instream)
      end
    end

    describe "#menu" do
      it "presents the user with a series of options" do
        described_class.stub(:process_command).and_return(:nil)
        described_class.menu
        described_class.view.outstream.include? "Please select an option from the following list:"
        described_class.view.outstream.include? "1. Play TTT!"
        described_class.view.outstream.include? "2. Load game"
        described_class.view.outstream.include? "3. Quit"
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
      it "displays 'Welcome to TTT'" do
        PlayerSelection.stub_chain(:new, :process).and_return(nil)
        BoardSelection.stub_chain(:new, :process).and_return(nil)
        TTT::GameBuilder.stub_chain(:new, :new_game).and_return(nil)
        described_class.view.outstream.include? "Welcome to TTT!"
      end

      it "displays a player selection prompt" do
        described_class.view.instream = StringIO.new("1\n1\n1\n0\n")
        BoardSelection.stub(:process).and_return(nil)
        TTT::GameBuilder.stub_chain(:new, :new_game).and_return(nil)
        described_class.stub(:play_game).and_return(nil)
        described_class.init_game
        described_class.view.outstream.include? "Please select an option for Player 1:"
        described_class.view.outstream.include? "Please select an option for Player 2:"
      end

      it "displays a board selection prompt" do
        described_class.view.instream = StringIO.new("1\n1\n1\n")
        TTT::GameBuilder.stub_chain(:new, :new_game).and_return(nil)
        described_class.stub(:play_game).and_return(nil)
        described_class.init_game
        described_class.view.outstream.include? "Please select which board you'd like to play:"
      end

      it "creates a new game" do
        described_class.view.instream = StringIO.new("1\n1\n1\n1\n0\n1\n3\n4\n6\nn\n")
        described_class.stub(:play_game).and_return(nil)
        described_class.init_game
        described_class.game.should_not be_nil
      end
    end

    describe "#play_game" do
      it "plays a game until the game is finished" do
        described_class.view.instream = StringIO.new("1\n1\n1\n0\n1\n4\n3\n8\nn\n")
        described_class.stub(:play_again).and_return(nil)
        described_class.init_game
        described_class.view.outstream.include? "Would you like to play again?"
      end
    end

    describe "#move_cycle" do
      before(:each) do
        described_class.stub(:process_next_move).and_return(nil)
        described_class.move_cycle
      end

      it "shows a help board so the user knows how to move" do
        described_class.view.should_receive(:output_help).with(described_class.game.board[])
        described_class.view.stub_chain(:output_board, :player_prompt).and_return(nil)
        described_class.move_cycle
      end

      it "shows the current game board" do
        described_class.view.should_receive(:output_board).with(described_class.game.board[])
        described_class.view.stub(:player_prompt).and_return(nil)
        described_class.move_cycle
      end

      it "shows a prompt for the current player" do
        described_class.view.should_receive(:player_prompt).with(described_class.game.current_player)
        described_class.move_cycle
      end
    end

    describe "#process_next_move" do
      it "calls TTT::Game#next_move if the current_player is an AI player" do
        described_class.game = ai_game
        described_class.game.should_receive(:next_move).and_return(0)
        described_class.process_next_move
      end

      it "asks waits for input if the current_player is not an AI player" do
        described_class.game = game
        described_class.view.instream = StringIO.new("1\n")
        described_class.should_receive(:process_human_move).with("1\n")
        described_class.process_next_move
      end
    end

    describe "#process_human_move" do
      it "marks the human move on the game board" do
        described_class.game.should_receive(:mark_move).with(1)
        described_class.process_human_move("1")
      end

      it "records the human move in the game history" do
        described_class.game.should_receive(:record_move).with(1)
        described_class.process_human_move("1")
      end
    end

    describe "#game=" do
      it "sets a new game object to the described class's game var" do
        described_class.game = nil
        described_class.game.should == nil
      end
    end

    describe "#game" do
      it "returns the current game object for the described class" do
        described_class.game = nil
        described_class.game.should be_nil
      end
    end

    describe "#view" do
      it "returns the current view object for the described class" do
        described_class.view = nil
        described_class.view.should be_nil
      end
    end

    describe "#view=" do
      it "sets the current view object for the described class with the arg provided it" do
        described_class.view = nil
        described_class.view.should be_nil
      end
    end

    describe "#eval_board_state" do
      before(:each) do
        described_class.game = game
        described_class.view = View.new(instream: input, outstream: output)
      end

      it "displays the winner if a winner is present" do
        described_class.game.board[] = %w(x x x x x x x x x)
        described_class.game.current_player = described_class.game.player2
        described_class.view.should_receive(:output_board).with(described_class.game.board[])
        described_class.view.should_receive(:winner_prompt).with("Player 1")
        described_class.eval_board_state
      end

      it "displays the draw prompt if the game results in a draw" do
        described_class.game.board[] = %w(a b c d e f g h i)
        described_class.view.should_receive(:output_board).with(described_class.game.board[])
        described_class.view.should_receive(:draw_prompt)
        described_class.eval_board_state
        described_class.view.outstream.include? "It's a draw"
      end
    end

    describe "#play_again" do
      before(:each) do
        described_class.game = game
        described_class.view = View.new(instream: input, outstream: output)
      end

      it "prompts the user to play again at the end of a game" do
        described_class.view.instream = StringIO.new("y\n")
        described_class.view.outstream.include? "Do you want to play again?"
      end

      it "exits if the user does not want to play again" do
        described_class.view.instream = StringIO.new("n\n")
        described_class.should_not_receive(:play)
      end
    end
  end
end
