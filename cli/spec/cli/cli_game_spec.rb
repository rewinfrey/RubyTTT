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
    let(:input1)      { StringIO.new("1\n1\n1\n0\n3\n1\n4\n2\nn\n") }
    let(:input)       { StringIO.new }
    let(:game)        { setup.new_game(player1: players.first, player2: players.first, board: boards.first) }
    let(:ai_game)     { setup.new_game(player1: players.last,  player2: players.last,  board: boards.first) }

    before(:each) do
      context.setup = TTT::Setup
      @cli_game = described_class.new(context, input, output)
    end

    describe "#play" do
      it "displays the main game menu to the user" do
        @cli_game.stub(:process_command).and_return(nil)
        @cli_game.presenter.should_receive(:menu)
        @cli_game.play
      end

      it "chooses the game made" do
        @cli_game.presenter.stub(:menu).and_return(1)
        @cli_game.should_receive(:process_command).with(1)
        @cli_game.play
      end
    end

    describe "#process_command" do
      context "matches user game mode selection with the proper game play option" do
        it "starts a new game when the user selects option 1" do
          @cli_game.should_receive(:init_game)
          @cli_game.process_command("1\n")
        end

        it "prompts the user to load a previously played game when the user selects option 2" do
          @cli_game.should_receive(:game_list)
          @cli_game.process_command("2\n")
        end

        it "exits the game when the user selects option 3" do
          @cli_game.should_receive(:exit)
          @cli_game.process_command("3\n")
        end

        it "reprompts the user with the main menu if invalid input is received" do
          @cli_game.should_receive(:play)
          @cli_game.process_command("aoivoijv\n")
        end
      end
    end

    describe "#init_game" do
      before(:each) do
        @cli_game.presenter.io.instream = StringIO.new("1\n1\n1\n")
      end

      it "presents a welcome prompt to the user" do
        @cli_game.presenter.should_receive(:welcome_prompt)
        @cli_game.stub(:get_player_selection => nil)
        @cli_game.stub(:get_board_selection => nil)
        @cli_game.stub(:build_game => nil)
        @cli_game.context.stub(:add_game => nil)
        @cli_game.stub(:play_game => nil)
        @cli_game.init_game
      end

      it "asks the user to select player types for player 1 and player 2" do
        @cli_game.should_receive(:get_player_selection)
        @cli_game.stub(:get_board_selection => nil)
        @cli_game.stub(:build_game => nil)
        @cli_game.context.stub(:add_game => nil)
        @cli_game.stub(:play_game => nil)
        @cli_game.init_game
      end

      it "asks the user to select the board type for the new game" do
        @cli_game.stub(:get_player_selection => nil)
        @cli_game.should_receive(:get_board_selection)
        @cli_game.stub(:build_game => nil)
        @cli_game.context.stub(:add_game => nil)
        @cli_game.stub(:play_game => nil)
        @cli_game.init_game
      end

      it "builds a new game based on the player type and board type selections of the user" do
        @cli_game.should_receive(:build_game)
        @cli_game.context.stub(:add_game => nil)
        @cli_game.stub(:play_game => nil)
        @cli_game.init_game
      end

      it "a new game is added to the datastore" do
        @cli_game.context.should_receive(:add_game)
        @cli_game.stub(:play_game => nil)
        @cli_game.init_game
      end

      it "begins to play the game after a new game has been successfully created" do
        @cli_game.should_receive(:play_game)
        @cli_game.init_game
        @cli_game.id.should_not be_nil
      end
    end

    describe "#get_player_selection" do
      it "selects the player type for player1 and player2 based on the context.players list" do
        context.players.length.times do |n|
          @cli_game.presenter.io.instream = StringIO.new("#{n + 1}\n#{n + 1}\n")
          players_selection = @cli_game.get_player_selection
          players_selection.player1.should == context.players[n]
          players_selection.player2.should == context.players[n]
        end
      end
    end

    describe "#get_board_selection" do
      it "selects the board type based on the context.boards list" do
        context.boards.length.times do |n|
          @cli_game.presenter.io.instream = StringIO.new("#{n + 1}\n#{n + 1}\n")
          board_selection = @cli_game.get_board_selection
          board_selection.board.should == context.boards[n]
        end
      end
    end

    describe "#build_game" do
      it "constructs a new game based on the player types and board type selected by the user" do
        p1 = [*1..context.players.length].sample
        p2 = [*1..context.players.length].sample
        b  = [*1..context.boards.length].sample
        @cli_game.presenter.io.instream = StringIO.new("#{p1}\n#{p2}\n#{b}\n")
        player_selection = @cli_game.get_player_selection
        board_selection = @cli_game.get_board_selection
        game = @cli_game.build_game(player_selection, board_selection)
        game.player1.should_not be_nil
        game.player2.should_not be_nil
        game.board.should_not be_nil
      end
    end

    describe "#play_game" do
      before(:each) do
        @cli_game.presenter.io.instream = StringIO.new("1\n1\n1\n0\n1\n4\n5\n8\n")
      end

      it "plays a game until the game is finished" do
        @cli_game.should_receive(:game_over)
        @cli_game.init_game
        @cli_game.game.board.board.should == ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', 'x']
     end
    end

    describe "#game_over" do
      it "prompts the user to walk the previously played game's history" do
        @cli_game.should_receive(:walk_history)
        @cli_game.stub(:play_again)
        @cli_game.game_over
      end

      it "prompts the user to play again" do
        @cli_game.should_receive(:play_again)
        @cli_game.stub(:walk_history)
        @cli_game.game_over
      end
    end

    describe "#play_again" do
      it "exits the program if the user doesn't want to play again" do
        PlayAgain.stub_chain(:new, :play_again?).and_return(nil)
        @cli_game.should_receive(:exit)
        @cli_game.stub(:play => nil)
        @cli_game.play_again
      end
    end

    describe "#game" do
      it "returns the current game from the datastore" do
        @cli_game.presenter.io.instream = StringIO.new("1\n1\n1\n")
        @cli_game.stub(:play_game => nil)
        @cli_game.game.should == context.get_game(@cli_game.id)
      end
    end

    describe "#move_cycle" do
      it "prompts the current player to move" do
        @cli_game.id = context.add_game(game)
        @cli_game.stub(:process_next_move => nil)
        @cli_game.presenter.should_receive(:player_prompt).with(game.board.board, game.show_history, game.current_player)
        @cli_game.move_cycle
      end

      it "receives the next move from the current_player" do
        @cli_game.id = context.add_game(ai_game)
        @cli_game.stub(:game => context.get_game(@cli_game.id))
        @cli_game.presenter.stub(:player_prompt => nil)
        @cli_game.should_receive(:process_next_move)
        @cli_game.move_cycle
      end
    end

    describe "#player_prompt" do
      it "calls player_prompt on @presenter" do
        @cli_game.id = context.add_game(game)
        @cli_game.presenter.should_receive(:player_prompt)
        @cli_game.player_prompt(context.get_game(@cli_game.id))
      end
    end

    describe "#process_next_move" do
      context "When an AI player move is processed" do
        it "returns the AI player's move if the current player is an AI player" do
          @cli_game.id = context.add_game(ai_game)
          original_board = @cli_game.game.board.board
          @cli_game.process_next_move
          original_board.should_not == @cli_game.game.board.board
        end
      end

      context "When a Human player move is processed" do
        before(:each) do
          @cli_game.id = context.add_game(game)
          @cli_game.presenter.io.instream = StringIO.new("1\n")
        end

        it "gets the human player's move" do
          @cli_game.process_next_move
          @cli_game.game.board.board.should == [' ', 'x', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        end

        it "validates the human player's move" do
          @cli_game.should_receive(:validate_move).with("1\n").and_return(true)
          @cli_game.process_next_move
        end

        it "updates the game with the human player's move" do
          @cli_game.game.board.board.should == [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          @cli_game.process_next_move
          @cli_game.game.board.board.should == [' ', 'x', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        end
      end

      it "evaluates the game after the move has been processed" do
        @cli_game.id = context.add_game(game)
        game = @cli_game.game
        game.board.board = ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', ' ']
        context.save_game(@cli_game.id, game)
        @cli_game.presenter.io.instream = StringIO.new("8\n") # win for 'x'
        @cli_game.presenter.should_receive(:process_winner)
        @cli_game.process_next_move
        @cli_game.game.winner?.should == true
      end
    end

    describe "#get_next_move" do
      it "prompts the human player for input on the command line if the current player is human" do
        @cli_game.id = context.add_game(game)
        @cli_game.presenter.io.instream = StringIO.new("1\n")
        @cli_game.presenter.should_receive(:input).and_return("1\n")
        @cli_game.process_next_move
      end

      it "gets the AI player's move when the current player is an AI player" do
        @cli_game.id = context.add_game(ai_game)
        original_board = @cli_game.game.board.board
        @cli_game.get_next_move
        original_board.should_not == @cli_game.game.board.board
      end
    end

    describe "#get_games" do
      it "asks the context object for alist of games saved to the datastore" do
        games = context.game_list
        @cli_game.get_games
        @cli_game.games.length.should == games.length
      end

      it "sets @games equal to nil if there are no games in the datastore" do
        @cli_game.context.stub(:game_list => [])
        @cli_game.get_games
        @cli_game.games.should == nil
      end
    end

    describe "#load_game" do
      before(:each) do
        @cli_game.stub(:game_list => nil)
      end
      it "prompts the user to select a game id from the game list" do
        @cli_game.presenter.should_receive(:process_game_list).with(@cli_game.games).and_return("1\n")
        @cli_game.context.stub(:get_game => nil)
        @cli_game.load_game
      end

      it "loads a game with a given id" do
        @cli_game.id = context.add_game(game)
        @cli_game.presenter.stub(:process_game_list => @cli_game.id)
        @cli_game.context.stub(:get_game => @cli_game.game)
        @cli_game.should_receive(:resume_game)
        @cli_game.load_game
      end
    end

    describe "#no_games" do
      it "prompts the users that no games exist in the datastore and returns to the main menu" do
        @cli_game.presenter.should_receive(:no_games)
        @cli_game.should_receive(:play)
        @cli_game.no_games
      end

      it "sleeps for one second" do
        @cli_game.should_receive(:sleep).with(1)
        @cli_game.stub(:play => nil)
        @cli_game.no_games
      end
    end

    describe "#resume_game" do
      it "prompts the player to resume playing an unfinished game loaded from the datastore" do
        @cli_game.id = context.add_game(game)
        @cli_game.presenter.should_receive(:player_prompt).with(@cli_game.game.board.board, @cli_game.game.show_history, @cli_game.game.current_player)
        @cli_game.stub(:play_game => nil)
        @cli_game.resume_game
      end

      it "displasy a loaded game's final state when a finished game is loaded from the db" do
        @cli_game.id = context.add_game(game)
        game = context.get_game(@cli_game.id)
        game.board.board = %w(a b c d e f g h i)
        @cli_game.context.save_game(@cli_game.id, game)
        @cli_game.stub(:play_game => nil)
        @cli_game.presenter.io.outstream.include? "It's a draw"
      end
    end

    describe "#game_list" do
      it "gets a list of games" do
        @cli_game.should_receive(:get_games)
        @cli_game.stub(:load_game)
        @cli_game.stub(:no_games)
        @cli_game.game_list
      end

      it "calls #load_game if there are games stored in the datastore" do
        @cli_game.should_receive(:load_game)
        @cli_game.game_list
      end

      it "calls #no_games if there are no games stored in the datastore" do
        @cli_game.stub(:get_games => nil)
        @cli_game.games = nil
        @cli_game.should_receive(:no_games)
        @cli_game.game_list
      end
    end

    describe "#walk_history" do
      it "makes a new WalkHistory object" do
        @cli_game.id = context.add_game(game)
        @cli_game.presenter.stub(:input => "n")
        @cli_game.stub(:play_again => nil)
        @cli_game.presenter.should_receive(:post_game_msg)
        @cli_game.walk_history
      end
    end
  end
end
