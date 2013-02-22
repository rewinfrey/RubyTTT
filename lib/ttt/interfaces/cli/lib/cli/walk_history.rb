module CLI
  class WalkHistory
    attr_accessor :presenter, :game, :move_traverser, :board
    def initialize(presenter, game)
      self.presenter      = presenter
      self.move_traverser = game.history.move_traverser
      self.game           = game
    end

    def post_game_msg
      presenter.post_game_msg
      process(presenter.input.chomp)
    end

    def process(selection)
      if selection =~ (/y|n/i)
        walk_msg if selection =~ (/y/i)
      else
        presenter.error
        post_game_msg
      end
    end

    def walk_msg
      presenter.clear
      presenter.output_board(build_board)
      presenter.walk_msg
      diff_index = presenter.input.chomp
      case diff_index
      when "-1" then walk_history(-1)
      when "0"  then return
      when "1"  then walk_history(1)
      else
        presenter.error
        walk_msg
      end
    end

    def walk_history(diff_index)
      move_traverser.adjust_move_index(diff_index)
      walk_msg
    end

    def build_board(board = game.board, move_index = move_traverser.move_index)
      move_traverser.history_board_builder(board, move_index)
    end
  end
end
