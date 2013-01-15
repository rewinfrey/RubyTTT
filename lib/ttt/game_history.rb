require 'ttt/move_history'

module TTT
  class GameHistory
    attr_accessor :history, :move_number
    def initialize
      self.history = []
      self.move_number = 1
    end

    def record_move(side, move)
      self.history << MoveHistory.new(:side => side, :move => move)
      inc_move_num
    end

    def inc_move_num
      self.move_number += 1
    end

    def show
      self.history
    end
  end
end
