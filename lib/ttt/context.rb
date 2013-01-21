module TTT
  class Context
    class << self
      def instance
        @instance ||= new
      end

      private :new
   end

    def setup=(setup_const)
      @setup = setup_const.new
    end

    def setup
      @setup
    end

    def create_game(player1, player2, board)
      game = @setup.new_game(:player1 => player1, :player2 => player2, :board => board)
      add_game(game)
    end

    def add_game(game)
      game_interactor.add_game(game)
    end

    def get_game(id)
      game_interactor.get_game(id)
    end

    def save_game(id, game)
      game_interactor.save_game(id, game)
    end

    def game_list
      game_interactor.game_list
    end

    def delete_game(id)
      game_interactor.delete_game(id)
    end

    def update_game(id, move, side)
      if game = db_instance.get_game(id)
        game_interactor.update_game(game, move, side)
        game_interactor.save_game(id, game)
      else
        nil
      end
    end

    def ai_move?(id)
      if game = db_instance.get_game(id)
        game_interactor.ai_move?(game)
      else
        nil
      end
    end

    def ai_move(id)
      if game = game_interactor.get_game(id)
        game_interactor.ai_move(id, game)
      else
        nil
      end
    end

    def finished?(id)
      if game = game_interactor.get_game(id)
        game_interactor.finished?(game)
      else
        nil
      end
    end

    def winner?(id)
      if game = game_interactor.get_game(id)
        game_interactor.winner?(game)
      else
        nil
      end
    end

    def winner(id)
      if game = game_interactor.get_game(id)
        game_interactor.winner(game)
      else
        nil
      end
    end

    def draw?(id)
      if game = game_interactor.get_game(id)
        game_interactor.draw?(game)
      else
        nil
      end
    end

    def which_board(id)
      if game = game_interactor.get_game(id)
        game_interactor.which_board(game)
      else
        nil
      end
    end

    def valid_move?(id, move)
      if game = game_interactor.get_game(id)
        game_interactor.valid_move?(game, move)
      else
        nil
      end
    end

    def get_history(id)
      if game = game_interactor.get_game(id)
        game_interactor.get_history(game)
      else
        nil
      end
    end

    def which_current_player?(id)
      if game = game_interactor.get_game(id)
        game_interactor.which_current_player?(game)
      else
        nil
      end
    end

    def board(id)
      if game = game_interactor.get_game(id)
        game_interactor.board(game)
      else
        nil
      end
    end

    private
    def db_instance
      @db_instance ||= @setup.new_db
    end

    def game_interactor
      @game_interactor ||= @setup.new_interactor
    end
  end
end
