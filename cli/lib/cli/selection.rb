module CLI
  class Selection
    attr_accessor :players, :boards, :presenter
    def input
      presenter.input
    end
  end
end
