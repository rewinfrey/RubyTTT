module TTT
  class GameInteractor
    def initialize(db)
      self.db = db
    end

    def add_game(game)
      db.add_game(game)
    end

    def get_game(id)
      db.get_game(id)
    end

    def game_list
      db.game_list
    end

    def save_game(id, game)
      db.save_game(id, game)
    end

    def delete_game(id)
      db.delete_game(id)
    end

    def ai_move?(game)
      game.ai_move?
    end

    def ai_move(id, game)
      game.next_move
      save_game(id, game)
      game
    end

    def finished?(game)
      game.finished?
    end

    def not_finished?(game)
      !game.finished?
    end

    def winner?(game)
      game.winner?
    end

    def winner(game)
      game.last_player
    end

    def draw?(game)
      game.draw?
    end

    def which_board(game)
      game.which_board
    end

    def valid_move?(game, move)
      game.valid_move?(move)
    end

    def get_history(game)
      game.show_history
    end

    def get_history_board(game)
      game.get_history_board
    end

    def initialize_history(game)
      game.initialize_history
    end

    def get_history_length(game)
      game.show_history.length
    end

    def switch_player(game)
      game.switch_player
    end

    def which_current_player?(game)
      game.which_current_player?
    end

    def board(game)
      game.board[]
    end

    def update_game(game, cell, side)
      mark_move(game, cell, side)
      record_move(game, cell, side)
      switch_player(game)
    end

    def mark_move(game, cell, side)
      game.mark_move(cell, side)
    end

    def record_move(game, cell, side)
      game.record_move(cell, side)
    end

    def adjust_move_index(game, value)
      game.history.move_traverser.adjust_move_index(value)
    end

    def get_move_index(game)
      game.history.move_traverser.move_index
    end

    private
    attr_accessor :db
  end
end
