require 'ttt/player'
module TTT
  class Human < Player
    def no_gui?
      false
    end

    def prompt
      "Enter move:"
    end
  end
end
