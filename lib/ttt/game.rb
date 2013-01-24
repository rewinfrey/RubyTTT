module TTT
  class Game
    attr_accessor :board, :player1, :player2, :current_player, :history, :db

    def initialize(options)
      self.board          = options[:board]
      self.player1        = options[:player1]
      self.player2        = options[:player2]
      self.current_player = self.player1
      self.history        = options.fetch(:history)
    end

    def ai_move?
      current_player.no_gui?
    end

    def which_board
      board.board_type
    end

    def next_move
      return nil unless ai_move?
      input = current_player.move(:board => board)
      mark_move(input)
      record_move(input)
      switch_player
      input
    end

    def valid_move?(input)
      input.class == Fixnum && 0 <= input && input <= (board[].length - 1) && board.free?(input.to_i)
    end

    def mark_move(cell, side = current_player.side)
      board.update(cell, side)
    end

    def record_move(cell, side = current_player.side)
      history.record_move(cell, side)
    end

    def show_history
      history.show
    end

    def adjust_move_index(index_diff)
      history.adjust_move_index(index_diff)
    end

    def get_history_board(move_number_limit = history.move_traverser.move_index)
      history.get_history_board(board, move_number_limit)
    end

    def initialize_history
      history.initialize_history
    end

    def switch_player
      if player1.side == current_player.side
        self.current_player = self.player2
      else
        self.current_player = self.player1
      end
    end

    def which_current_player?
      current_player.equal?(player1) ? "Player 1" : "Player 2"
    end

    def last_player
      current_player == player1 ? "Player 2" : "Player 1"
    end

    def finished?
      board.finished?
    end

    def not_finished?
      !board.finished?
    end

    def winner?
      board.winner?
    end

    def draw?
      board.draw_game?
    end

    def board_arr
      board[]
    end
  end
end
