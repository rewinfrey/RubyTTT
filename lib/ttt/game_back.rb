module TTT
  class Game
    attr_accessor :board, :player1, :player2, :gameio, :current_player, :ai_difficulty, :game_setup, :history

    def initialize(options)
      self.board          = options[:board]
      self.gameio         = options.fetch(:gameio, nil)
      self.player1        = options[:player1]
      self.player2        = options[:player2]
      self.game_setup     = options.fetch(:game_setup, nil)
      self.current_player = self.player1
      self.history        = options.fetch(:history, GameHistory.new)
    end

    def play
      while !board.finished?
        move
      end
    end

    def move
      show_board
      select_move_prompt
      input = current_player.move(:gameio => gameio, :board => board)
      if valid_move?(input.to_i) && board.free?(input.to_i)
        process_move(input)
      else
        process_move_input_error
        show_board
        move
      end
    end

    def ai_move?
      current_player.no_gui?
    end

    def which_board?
      board.to_s
    end

    def next_move
      return nil unless ai_move?
      input = current_player.move(:board => board)
      mark_move(input)
      record_move(input)
      switch_player
      input
    end

    def select_move_prompt
      if current_player.class.to_s =~ (/ai/i)
        gameio.computer_prompt
      else
        gameio.human_prompt
      end
    end

    def valid_move?(input)
      input.class == Fixnum && 0 <= input && input <= (board[].length - 1)
    end

    def process_move_input_error
      gameio.prompt_move_error
    end

    def mark_move(cell, side = current_player.side)
      board.update(cell, side)
    end

    def record_move(move)
      history.record_move(current_player.side, move)
    end

    def show_history
      history.show
    end

    def switch_player
      if player1.side == current_player.side
        self.current_player = self.player2
      else
        self.current_player = self.player1
      end
    end

    def opposite(side)
      side == "x" ? "o" : "x"
    end

    def which_current_player?
      current_player.equal?(player1) ? "Player 1" : "Player 2"
    end

    def last_player?
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
  end
end
