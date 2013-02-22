require 'yaml'

class TttGame
  def self.evaluate_game(game_id, context)
    @game_id, @context = game_id, context
    if finished? && winner?
      winner = @context.winner(@game_id) + " is the winner!"
      return winner, "end_game"
    elsif finished?
      return "It's a draw", "end_game"
    else
      player = @context.which_current_player?(@game_id) + "'s turn"
      return player, "show"
    end
  end

  def self.get_history_length(game_id, context)
    context.get_history_length(game_id)
  end

  def self.get_history_board(game, move_index_diff)
    move_traverser = game.history.move_traverser
    move_traverser.adjust_move_index(move_index_diff.to_i)
    move_traverser.history_board_builder(game.board, move_traverser.move_index)
  end

  def self.finished?
    @context.finished?(@game_id)
  end

  def self.winner?
    @context.winner?(@game_id)
  end
end
