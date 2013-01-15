require 'spec_helper'
require 'stringio'

module CLI
  describe View do
    let(:input)     { StringIO.new }
    let(:output)    { StringIO.new }
    let(:view)      { View.new(outstream: output, instream: input) }
    let(:players)   { TTT::GameBuilder.new.players }
    let(:boards)    { TTT::GameBuilder.new.boards  }
    let(:game)      { TTT::GameBuilder.new.new_game(player1: players.first, player2: players.first, board: boards.first) }
    let(:game1)     { TTT::GameBuilder.new.new_game(player1: players.first, player2: players.first, board: boards[1])    }
    let(:game2)     { TTT::GameBuilder.new.new_game(player1: players.first, player2: players.first, board: boards[2])    }
    let(:board)     { game.board }
    let(:board1)    { game1.board }
    let(:board2)    { game2.board }

    describe "#output" do
      it "responds to output" do
        view.should respond_to(:output)
      end

      it "outputs whatever string is passed to it" do
        view.output('Welcome to TTT!')
        view.outstream.string.split("\n").include? 'Welcome to TTT!'
      end
    end

    describe "#computer_prompt" do
      it "displays 'Computer thinking...'" do
        view.computer_prompt
        view.outstream.string.split("\n").include? 'Computer thinking...'
      end
    end

    describe "#output_board" do
      it "calls output_three_by_three when a regular game board is passed" do
        view.should_receive(:output_three_by_three).with(board[]).and_return(true)
        view.output_board(board[])
      end

      it "cals output_four_by_four when a game board is a 4x4 board" do
        view.should_receive(:output_four_by_four).with(board1[]).and_return(true)
        view.output_board(board1[])
      end

      it "calls output_3d when a game board is a 3d board" do
        view.should_receive(:output_3d).with(board2[]).and_return(true)
        view.output_board(board2[])
      end
    end

    describe "#output_three_by_three" do
      it "prints game board" do
        view.output_three_by_three(board[])
        view.outstream.string.chomp.should ==      "\n     |     |     \n"+
                                                     "-----------------\n"+
                                                     "     |     |     \n"+
                                                     "-----------------\n"+
                                                     "     |     |     "
      end

      it "updates the board after move is made to cell 1" do
        board.update(1, "x")
        view.output_three_by_three(board[])
        view.outstream.string.chomp.should ==  "\n     |  x  |     \n"+
                                                      "-----------------\n"+
                                                      "     |     |     \n"+
                                                      "-----------------\n"+
                                                      "     |     |     "
      end

      it "updates the board after move is made to cell 4" do
        board.update(1, "x")
        board.update(4, "o")
        view.output_three_by_three(board[])
        view.outstream.string.chomp.should ==  "\n     |  x  |     \n"+
                                                      "-----------------\n"+
                                                      "     |  o  |     \n"+
                                                      "-----------------\n"+
                                                      "     |     |     "
      end
    end

    describe "#output_four_by_four" do
      it "displays a four by four board" do
        view.output_four_by_four(board1[])
        view.outstream.string.chomp.should == "\n     |     |     |     \n"+
                                                "-----------------------\n"+
                                                "     |     |     |     \n"+
                                                "-----------------------\n"+
                                                "     |     |     |     \n"+
                                                "-----------------------\n"+
                                                "     |     |     |      "

      end

      it "updates the board after a move is made to cell 4" do
        board1.update(4, "x")
        view.output_four_by_four(board1[])
        view.outstream.string.chomp.should == "\n     |     |     |     \n"+
                                                "-----------------------\n"+
                                                "  x  |     |     |     \n"+
                                                "-----------------------\n"+
                                                "     |     |     |     \n"+
                                                "-----------------------\n"+
                                                "     |     |     |      "
      end

      it "updates the board after a move is made to cell 10" do
        board1.update(10, "x")
        view.output_four_by_four(board1[])
        view.outstream.string.chomp.should == "\n     |     |     |     \n"+
                                                "-----------------------\n"+
                                                "     |     |     |     \n"+
                                                "-----------------------\n"+
                                                "     |     |  x  |     \n"+
                                                "-----------------------\n"+
                                                "     |     |     |      "
      end
    end

    describe "#input" do
      it "takes whatever input the user gives" do
        view.instream = StringIO.new("hello\nworld\n")
        view.input.should == "hello\n"
        view.input.should == "world\n"
      end
    end

    describe "#winner_prompt" do
      it "displays 'Player 1 is the winner!" do
        view.winner_prompt("Player 1")
        view.outstream.string.split("\n").include? "Player 1 is the winner!"
      end
    end

    describe "#draw_prompt" do
      it "displays 'It's a draw!'" do
        view.draw_prompt
        view.outstream.string.split("\n").include? "It's a draw!"
      end
    end

    describe "#regular_move_prompt" do
      it "displays a help menu to indicate how the user can move with a 3x3 board" do
        view.regular_move_prompt
        view.outstream.string.chomp.should == "\n  0  |  1  |  2  \n"+
                                                     "-----------------\n"+
                                                     "  3  |  4  |  5  \n"+
                                                     "-----------------\n"+
                                                     "  6  |  7  |  8  "

      end
    end

    describe "#output_move_error" do
      it "displays '\nCannot move there! >.< Please try another square'" do
        view.output_move_error
        view.outstream.string.split("\n").include? "\nCannot move there! >.< Please try another square."
      end
    end

    describe "#four_by_four_move_prompt" do
      it "displays a help menu to indicate how the user can move on a 4x4 board" do
        view.four_by_four_move_prompt
        view.outstream.string.chomp.should == "\n  0  |  1  |  2  |  3  \n"+
                                                "-----------------------\n"+
                                                "  4  |  5  |  6  |  7  \n"+
                                                "-----------------------\n"+
                                                "  8  |  9  | 10  | 11  \n"+
                                                "-----------------------\n"+
                                                " 12  | 13  | 14  | 15   "
      end
    end

    describe "#output_help" do
      it "displays a 3x3 help prompt when the input is a 3x3 board" do
        view.should_receive(:regular_move_prompt).and_return(true)
        view.output_help(board[])
      end

      it "displays a 4x4 help prompt when the input is a 4x4 board" do
        view.should_receive(:four_by_four_move_prompt).and_return(true)
        view.output_help(board1[])
      end
    end
  end
end
