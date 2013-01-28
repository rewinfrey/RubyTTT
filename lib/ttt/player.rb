module TTT
  class Player
    attr_accessor :side
    def initialize(options)
      self.side = options.fetch(:side)
    end

    def move; end

    def ==(other_player)
      self.class == other_player.class &&
        side == other_player.side
    end
  end
end
