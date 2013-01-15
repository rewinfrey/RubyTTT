require 'ttt/ai'
module TTT
  class AIEasy < AI
    def minimax
      move = nil
      available_moves.each do |square|
        move ||= square if Time.new.usec % 3 == 0
      end
      return(move ? move : available_moves.last)
    end
  end
end
