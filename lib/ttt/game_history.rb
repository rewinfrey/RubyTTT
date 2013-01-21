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
  end
end
