require 'spec_helper'

describe TttGame do
  let(:context) { TTT::Context.instance }
  let(:setup)   { TTT::Setup }

  before(:each) do
    context.setup = setup
    @game_id = context.create_game(context.players.first, context.players.first, context.boards.first)
    @game    = context.get_game(@game_id)
  end

  describe "#evaluate_game" do
    it "returns 'It's a draw' when the final result of a game is a draw" do
      @game.board.board = %w(a b c d e f g h i)
      context.save_game(@game_id, @game)
      message, view = described_class.evaluate_game(@game_id, context)
      message.should == "It's a draw"
      view.should == "end_game"
    end

    it "returns 'Player 1' is the winner when the final result is player 1 is the winner" do
      @game.board.board = Array.new(9, 'x')
      @game.switch_player
      context.save_game(@game_id, @game)
      message, view = described_class.evaluate_game(@game_id, context)
      message.should == "Player 1 is the winner!"
      view.should == "end_game"
    end

    it "returns 'Player 2' is the winner when the final result is player 2 is the winner" do
      @game.board.board = Array.new(9, 'o')
      2.times { @game.switch_player }
      context.save_game(@game_id, @game)
      message, view = described_class.evaluate_game(@game_id, context)
      message.should == "Player 2 is the winner!"
      view.should == "end_game"
    end

    it "returns 'Player 1's turn' when the game is not finished and it is player 1's turn" do
      @game.board.board = Array.new(9, ' ')
      message, view = described_class.evaluate_game(@game_id, context)
      message.should == "Player 1's turn"
      view.should == "show"
    end

    it "returns 'Player 2's turn' when the game is not finished and it is player 2's turn" do
      @game.board.board = Array.new(9, ' ')
      @game.mark_move(1, 'x')
      @game.switch_player
      context.save_game(@game_id, @game)
      message, view = described_class.evaluate_game(@game_id, context)
      message.should == "Player 2's turn"
      view.should == "show"
    end
  end

  describe "#get_history_length" do
    it "returns the total number of moves for a game" do
      @game.record_move(1, 'x')
      @game.record_move(2, 'o')
      context.save_game(@game_id, @game)
      described_class.get_history_length(@game_id, context)
    end
  end

  describe "#get_history_board" do
    it "returns a board array representing the move history board at a specified move index" do
      @game.record_move(1, 'x')
      @game.record_move(2, 'o')
      context.save_game(@game_id, @game)
      described_class.get_history_board(@game, -1).should == [' ', 'x', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      described_class.get_history_board(@game, -2).should == Array.new(9, " ")
    end
  end
end
