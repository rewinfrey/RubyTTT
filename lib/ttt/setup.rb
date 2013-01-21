require 'ttt/config_helper'
require 'ttt/game'

module TTT
  class Setup
    def players
      ConfigHelper.player_types
    end

    def boards
      ConfigHelper.board_types
    end

    def new_game(options)
      Game.new(:player1 => instantiate_player(1, options.fetch(:player1)),
               :player2 => instantiate_player(2, options.fetch(:player2)),
               :board   => instantiate_board(options.fetch(:board)),
               :history => instantiate_history)
    end

    def new_db
      instantiate_db
    end

    def new_interactor
      instantiate_interactor
    end

    def db
      ConfigHelper.get_db_const
    end

    def interactor
      ConfigHelper.get_game_interactor_const
    end

    private
    def instantiate_interactor
      ConfigHelper.get_game_interactor_const.new(instantiate_db)
    end

    def instantiate_db
      ConfigHelper.get_db_const.new(:port => ConfigHelper.port, :http_backend => ConfigHelper.http_backend, :bucket => ConfigHelper.bucket)
    end

    def instantiate_history
      ConfigHelper.get_history_const.new
    end

    def instantiate_player(player_num, player_type)
      side = player_num == 1 ? "x" : "o"
      ConfigHelper.get_player_const(player_type).new(:side => side)
    end

    def instantiate_board(board_type)
      ConfigHelper.get_board_const(board_type).new
    end
  end
end
