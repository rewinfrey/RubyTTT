module CLI
  class Selection
    attr_accessor :players, :boards, :presenter
    def initialize(options)
      self.presenter = options.fetch(:presenter)
    end

    def input
      view.input
    end
  end
end
