module CLI
  class BoardSelection < Selection
    attr_accessor :board, :boards, :presenter

    def initialize(boards, presenter)
      self.boards = boards
      self.presenter = presenter
    end

    def process
      presenter.board_selection_prompt(boards)
      process_board_selection(presenter.input.chomp.to_i)
      self
    end

    def process_board_selection(selection)
      if board_selection_input_valid?(selection)
        set_board_string(selection)
      else
        presenter.error
        process
      end
    end

    def board_selection_input_valid?(selection)
      return false if selection.class == Float
      0 < selection && selection <= boards.length
    end

    def set_board_string(selection)
      self.board = boards[selection - 1]
    end
  end
end
