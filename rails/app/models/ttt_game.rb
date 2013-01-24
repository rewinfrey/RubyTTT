require 'yaml'

class TttGame
  def self.process_game(id, context)
    if context.finished?(id)
      if context.winner?(id)
        winner = context.winner(id) + " is the winner!"
        return winner, "end_game"
      else
        return "It's a draw", "end_game"
      end
    else
      player = context.which_current_player?(id) + "'s turn."
      return player, "show"
    end
  end

  def self.get_history_max_length(game)
    game.show_history.length if game
  end

  def self.move_index(game)
    game.history.move_traverser.move_index
  end

  def self.get_history_board(game, move_index_diff)
    move_traverser = game.history.move_traverser
    move_traverser.adjust_move_index(move_index_diff.to_i)
    history_board = YAML.load(YAML.dump(game.board))
    history_board.board = move_traverser.history_board_builder(history_board, move_traverser.move_index)
    history_board
  end
end
