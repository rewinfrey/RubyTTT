require 'ttt/ai'
module TTT
  class AIHard < AI
    attr_accessor :max_ply

    def move(options)
      board(options[:board].dup)
      self.max_ply = max_ply_for(available_moves.length)
      minimax
    end

    def minimax(max_player = true, ply = 0, alpha = -1000, beta = 1000)
      return(board.winner? ? winning_score(max_player, ply) : 0) if base_case_satisfied?
      ab_value            = max_player ? alpha : beta
      return ab_value if ply >= max_ply

      ab_value, best_move = gen_score_game_tree(max_player, ply, alpha, beta, ab_value)
      return(ply == 0 ? best_move : ab_value)
    end

    def gen_score_game_tree(max_player, ply, alpha, beta, ab_value)
      best_move = 0
      available_moves.each do |index|
        board[][index]                   = mark_curr_player_side(max_player)
        score                            = minimax(!max_player, ply + 1, alpha, beta)
        alpha, beta, ab_value, best_move = eval_score(max_player, index, score, alpha, beta, ab_value, best_move)
        undo_move(index)
        break if alpha_beta_swapped?(alpha, beta)
      end
      [ab_value, best_move]
    end

    def eval_score(max_player, index, score, alpha, beta, ab_value, best_move)
      best_move, alpha, ab_value = [index, score, score] if max_player && score > ab_value
      beta, ab_value             = [score, score]        if !max_player && score < ab_value
      [alpha, beta, ab_value, best_move]
    end

    def alpha_beta_swapped?(alpha, beta)
      alpha >= beta
    end

    def base_case_satisfied?
      board.winner? || board.draw_game?
    end

    def winning_score(max_player, ply)
      max_player ? (-1000 + ply) : (1000 - ply)
    end

    def mark_curr_player_side(max_player)
      max_player ? side : opposite_side(side)
    end

    def max_ply_for(moves)
      if moves > 16
        return 7
      elsif moves > 10
        return 9
      else
        return 11
      end
    end
  end
end
