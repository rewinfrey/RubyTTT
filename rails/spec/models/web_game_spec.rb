require 'spec_helper'

describe WebGame do
  let(:game_builder) { TTT::GameBuilder.new }
  let(:players)      { game_builder.players }
  let(:boards)       { game_builder.boards  }
  let(:game)         { game_builder.new_game(board: boards.first, player1: players.first, player2: players.first) }
  let(:ai_game)      { game_builder.new_game(board: boards.first, player1: players.last,  player2: players.last)  }
  let(:web_game)     { WebGame.new(game: game) }

  describe "current_player_ai?" do
    it "returns nil when a game's current_player is not an AI" do
      web_game.current_player_ai?.should == false
    end

    it "returns an integer when a game's current_player is an AI" do
      web_game.game = ai_game
      web_game.current_player_ai?.should_not == false
    end
  end

  describe "mark_move" do
    it "marks a valid move on the game board" do
      web_game.mark_move(1)
      web_game.game.board.board[1].should_not == " "
    end
  end

  describe "swtich_player" do
    it "switches the game's current player to the other player" do
      web_game.game.current_player = web_game.game.player1
      web_game.switch_player
      web_game.game.current_player.equal?(web_game.game.player2)
      web_game.switch_player
      web_game.game.current_player.equal?(web_game.game.player1)
    end
  end

  describe "valid_move?" do
    it "returns true if a newly inputted move is valid (exists in the range of the board) and also is an empty square on the board" do
      web_game.valid_move?(1).should == true
    end

    it "returns false if a newly inputted move is out of the range of the game board" do
      web_game.valid_move?(100).should == false
    end

    it "returns false if a newly inputted move is a square that is already occuppied on the game board" do
      web_game.game.board.board[1] = "x"
      web_game.valid_move?(1).should == false
    end
  end

  describe "draw_game?" do
    it "returns true when a game is finished and is a draw" do
      web_game.game.board[] = %w(a b c d e f g h i)
      web_game.draw_game?.should == true
    end

    it "returns false when a game is not finished and is not a draw" do
      web_game.game.board[] = Array.new(9, " ")
      web_game.draw_game?.should == false
    end
  end

  describe "who_is_winner?" do
    it "returns player 1 if current player is player 2" do
      web_game.game.current_player.side = "o"
      web_game.who_is_winner?.should == "Player 1"
    end

    it "returns player 2 if current player is player 1" do
      web_game.game.current_player.side = "x"
      web_game.who_is_winner?.should == "Player 2"
    end
  end
end
