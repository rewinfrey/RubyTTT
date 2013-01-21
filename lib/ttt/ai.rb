require 'ttt/player'
require 'ttt/minimax'

module TTT
  class AI < Player
    include Minimax
    attr_accessor :board, :max_ply

    def move(options)
      self.board = (options[:board].dup)
    end

    def opposite_side(side)
      side == "x" ? "o" : "x"
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
