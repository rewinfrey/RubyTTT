require 'ttt/ai'
module TTT
  class AIMedium < AI

    def move(options)
      super
      self.max_ply = set_max_ply(available_moves.length)
      minimax
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
  end
end
