module TTT
  class MoveTraverser
    attr_accessor :game_history, :move_index
    def initialize(game_history)
      self.move_index   = 0
      self.game_history = game_history
    end

    def max_length
      game_history.history.length
    end

    def adjust_move_index(distance)
      if move_index + distance >= 0 && move_index + distance <= max_length
        self.move_index += distance
      elsif move_index + distance < 0
        self.move_index = 0
      else
        self.move_index = max_length
      end
    end

    def history_board_builder(board, move_number)
      history = game_history.history.dup
      board.board.length.times do |n|
        if (n + 1) <= move_number
          move_history = history.shift
          cell = move_history.move
          side = move_history.side
          board.update cell, side
        end
      end
      board.board
    end
  end
end
