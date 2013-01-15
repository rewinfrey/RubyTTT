require 'ttt/ai'
module TTT
  class AIMedium < AI
    attr_accessor :max_ply, :best

    def move(options)
      board(options[:board].dup)
      self.max_ply = set_max_ply(available_moves.length)
      self.best    = {}
      self.best[:index] = nil
      self.best[:score] = 0
      minimax
    end

    def minimax(max_player = true, ply = 0, min_score = 1000, max_score = -1000)
      if board.winner?
        return(max_player ? (-1000 + ply) : (1000 - ply))
      elsif board.draw_game?
        return 0
      end

      if ply >= max_ply
        return(max_player ? (max_score) : (min_score))
      end

      best_move = 0
      score = (max_player ? max_score : min_score )
      available_moves.each do |index|
        board[][index] = ( max_player ? side : opposite_side(side) )
        score          = minimax(!max_player, ply + 1, min_score, max_score)
        undo_move(index)
        if max_player && score > max_score
          max_score  = score
          best_move  = index
        elsif !max_player && score < min_score
          min_score  = score
#          best_move  = index #if min_score >= max_score.abs
        end
        break if max_min_swapped?(max_score, min_score)
      end

      return( ply == 0 ? best_move : ( max_player ? max_score : min_score ) )
    end

    def set_max_ply(moves)
      if moves > 15
       return 3
      elsif moves > 5
       return 5
      else
       return 7
      end
    end

    def max_min_swapped?(max, min)
      max >= min
    end
  end
end
