require 'ttt/ai'
module TTT
  class AIEasy < AI
    def move(options)
      super
      random_move
    end

    def random_move
      move = nil
      available_moves.each do |square|
        move ||= square if Time.new.usec % 3 == 0
      end
      return(move ? move : available_moves.last)
    end
  end
end
