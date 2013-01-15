require 'spec_helper'

module TTT
  describe GameHistory do
    let(:players) { GameBuilder.new.players }
    let(:boards)  { GameBuilder.new.boards  }
    let(:game)    { GameBuilder.new.new_game(player1: players.first, player2: players.first, board: boards.first) }
    let(:history) { game.history }

    describe "#record_move" do
      it "records each move and side" do
        game.mark_move(0)
        game.history.should_receive(:record_move).with("x", 0)
        game.record_move(0)
      end
    end

    describe "#inc_move_num" do
      it "increments the move number" do
        history.inc_move_num
        history.move_number.should == 2
      end
    end

    describe "#history" do
      it "returns the game history" do
        game.show_history.should == []
        game.record_move(0)
        game.show_history.include? MoveHistory.new(:side => "x", :move => 0)
      end
    end
  end
end
