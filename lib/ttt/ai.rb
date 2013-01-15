require 'ttt/player'
module TTT
  class AI < Player
    def move(options)
      board(options[:board].dup)
      minimax
    end

    def opposite_side(side)
      side == "x" ? "o" : "x"
    end

    def board(board = nil)
      @board ||= board
    end

    def available_moves
      board[].each.with_index.map { |element, index| index if element == " " }.compact
    end

    def undo_move(index)
      board[][index] = " "
    end

    def no_gui?
      true
    end

    def prompt
      "Computer thinking."
    end
  end
end
