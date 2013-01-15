module TTT
  class Player
    attr_accessor :side
    def initialize(options)
      self.side = options.fetch(:side)
    end

    def move; end
  end
end
