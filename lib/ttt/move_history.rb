module TTT
  class MoveHistory
    attr_reader :side, :move
    def initialize(options)
      @side = options.fetch(:side)
      @move = options.fetch(:move)
    end
  end
end

