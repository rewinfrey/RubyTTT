require 'ttt/move_history'
require 'ttt/move_traverser'

module TTT
  class GameHistory
    attr_accessor :history, :move_traverser
    def initialize
      self.history         = []
      self.move_traverser  = MoveTraverser.new(self)
    end

    def record_move(cell, side)
      self.history << MoveHistory.new(:move => cell, :side => side)
      inc_move_index
    end

    def inc_move_index
      self.move_traverser.move_index = history.length
    end

    def show
      self.history
    end

    def adjust_move_index(index_diff)
      move_traverser.adjust_move_index(index_diff)
    end

    def get_history_board(board, move_number_limit = move_traverser.move_index)
      move_traverser.history_board_builder(board, move_number_limit)
    end

    def initialize_history
      move_traverser.initialize_history
    end
  end
end
