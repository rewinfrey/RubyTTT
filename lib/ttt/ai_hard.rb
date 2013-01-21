require 'ttt/ai'
module TTT
  class AIHard < AI

    def move(options)
      super
      self.max_ply = max_ply_for(available_moves.length)
      minimax
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
