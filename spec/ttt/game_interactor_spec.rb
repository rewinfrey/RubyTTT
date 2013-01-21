require 'spec_helper'

module TTT
  describe GameInteractor do
    let(:game)   { Game.new(player1: Human.new(side: "x"), player2: Human.new(side: "o"), board: ThreeByThree.new, history: GameHistory.new) }
    let(:ai_game){ Game.new(player1: AIEasy.new(side: "x"), player2: AIEasy.new(side: "o"), board: ThreeByThree.new, history: GameHistory.new) }
    let(:bucket) { "game_interactor_bucket" }
    let(:db)     { RiakDB.new(bucket: bucket, port: 8091) }
    let(:gi)     { GameInteractor.new(db) }

    describe "#ai_move?" do
      it "returns true if the next move is from an AI player" do
        gi.ai_move?(ai_game).should == true
      end

      it "returns false if the next move is not from an AI player" do
        gi.ai_move?(game).should == false
      end
    end

    describe "#ai_move" do
      it "directs the ai to move, side effect is board is updated and current player switched" do
        cur_player = ai_game.current_player
        board      = ai_game.board.board.dup
        id         = gi.add_game(ai_game)
        gi.ai_move(id, ai_game)
        board.should_not == ai_game.board.board
        cur_player.should_not.eql? ai_game.current_player
        ai_game.history.history.length.should == 1
      end

      it "does nothing if the current player is a human player" do
        cur_player = game.current_player
        board      = game.board.board.dup
        id         = gi.add_game(game)
        gi.ai_move(id, game)
        board.should == game.board.board
        cur_player.should.eql? game.current_player
        game.history.history.length.should == 0
      end
    end

    describe "#finished?" do
      it "returns true if the game is over" do
        game.board.board = %w(a b c d e f g h i)
        gi.finished?(game).should == true
      end

      it "returns false if the game is not over" do
        gi.finished?(game).should == false
      end
    end

    describe "#winner?" do
      it "returns true if a winner is found" do
        game.board.board = %w(x x x x x x x x x)
        gi.winner?(game).should == true
      end

      it "returns false if a winner is not found" do
        gi.winner?(game).should == false
      end
    end

    describe "#winner" do
      it "returns 'Player 1' when the current player is player 2" do
        game.switch_player()
        gi.winner(game).should == "Player 1"
      end

      it "returns 'Player 2' when the current player is player 1" do
        gi.winner(game).should == "Player 2"
      end
    end

    describe "#draw?" do
      it "returns true if the game is a draw" do
        game.board.board = %w(a b c d e f g h i)
        gi.draw?(game).should == true
      end

      it "returns false if the game is not a draw" do
        game.board.board = Array.new(9, " ")
        gi.draw?(game).should == false
      end
    end

    describe "#which_board" do
      it "returns `three_by_three` when the board type is 3x3" do
        gi.which_board(game).should == "three_by_three"
      end

      it "returns `four_by_four` when the board type is 4x4" do
        game.board = FourByFour.new
        gi.which_board(game).should == "four_by_four"
      end

      it "returns `three_by_three_by_three` when the board type is 3x3x3" do
        game.board = ThreeByThreeByThree.new
        gi.which_board(game).should == "three_by_three_by_three"
      end
    end

    describe "#valid_move?" do
      it "returns true if the move input by the user is a valid move for the current game board" do
        game.board.board = Array.new(9, " ")
        gi.valid_move?(game, 1).should == true
      end

      it "returns false if the move input by the user is not a valid move for the current game board" do
        game.board.board = %w(a b c d e f g h i)
        gi.valid_move?(game, 1).should == false
      end
    end

    describe "#get_history" do
      it "returns an empty array when it's a new game (no move history)" do
        gi.get_history(game).should == []
      end

      it "returns an array with one move history object after the first move" do
        game.record_move(1)
        move_hist_arr = gi.get_history(game)
        move_hist_arr.length.should == 1
        move_hist_arr[0].side.should == "x"
        move_hist_arr[0].move.should == 1
      end

      it "returns an array of two move history objects after the second move" do
        game.record_move(1)
        game.switch_player
        game.record_move(2)
        move_hist_arr = gi.get_history(game)
        move_hist_arr.length.should == 2
        move_hist_arr[0].side.should == "x"
        move_hist_arr[1].side.should == "o"
        move_hist_arr[0].move.should == 1
        move_hist_arr[1].move.should == 2
      end
    end

    describe "#switch_player" do
      it "sets the other player as the current player" do
        game.current_player = game.player1
        player2 = game.player2
        gi.switch_player(game)
        game.current_player.eql? player2
      end
    end

    describe "#which_current_player?" do
      it "returns 'Player 1' if the current player is player 1" do
        game.current_player = game.player1
        gi.which_current_player?(game).should == "Player 1"
      end

      it "returns 'Player 2' if the current player is player 2" do
        game.current_player = game.player2
        gi.which_current_player?(game).should == "Player 2"
      end
    end

    describe "#board_arr" do
      it "returns the board array" do
        gi.board(game).should == Array.new(9, " ")
        game.board[] = %w(a b c d e f g h i)
        gi.board(game).should == %w(a b c d e f g h i)
      end
    end

    describe "#mark_move" do
      it "marks a move for a game" do
        game.board[] = Array.new(9, " ")
        gi.mark_move(game, 0, 'x')
        game.board[].should == ['x', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
        gi.mark_move(game, 1, 'o')
        game.board[].should == ['x', 'o', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      end
    end

    describe "#record_move" do
      it "records the move for the game" do
        gi.record_move(game, 0, 'x')
        gi.get_history(game)[0].move.should == 0
        gi.get_history(game)[0].side.should == 'x'
      end
    end

    describe "#not_finished" do
      it "returns the opposite of #finished?" do
        gi.not_finished?(game).should == true
        game.board[] = %w(a b c d e f g h i)
        gi.not_finished?(game).should == false
      end
    end
  end
end
