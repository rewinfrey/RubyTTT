require 'spec_helper'

module TTT
  describe GameHistory do
    let(:setup)     { Setup.new }
    let(:players)   { setup.players }
    let(:boards)    { setup.boards  }
    let(:game)      { setup.new_game(player1: players.first, player2: players.first, board: boards.first) }
    let(:history)   { game.history }

    describe "#new" do
      it "creates a new game history object" do
        history.should respond_to(:history)
        history.should respond_to(:move_traverser)
      end
    end

    describe "#record_move" do
      it "records each move and side" do
        game.history.should_receive(:record_move).with(0, 'x')
        game.record_move(0)
      end
    end

    describe "#show" do
      it "returns the game history" do
        game.show_history.should == []
        game.record_move(0, 'x')
        game.show_history.include? MoveHistory.new(:side => "x", :move => 0)
      end
    end

    describe "#inc_move_index" do
      it "increments the move index for the move traverser" do
        game.history.move_traverser.move_index = 0
        game.history.record_move(0, 'x')
        game.history.move_traverser.move_index.should == 1
      end
    end
  end
end
