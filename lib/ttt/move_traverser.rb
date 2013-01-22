require 'yaml'

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

    def history_board_builder(board, move_number_limit)
      total_moves    = game_history.history.length
      clone_board    = YAML.load(YAML.dump(board))
      clean_board(clone_board)
      clone_history  = YAML.load(YAML.dump(game_history.history))

      total_moves.times do |n|
        cur_move = clone_history.shift
        if (n + 1) <= move_number_limit
          clone_board.update(cur_move.move, cur_move.side)
        end
      end
      clone_board.board
    end

    def clean_board(board)
      board.board.each_index { |index| board.update index, " " }
    end
  end
end
