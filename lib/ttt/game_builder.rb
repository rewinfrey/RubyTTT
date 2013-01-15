require 'ttt/config_helper'
require 'ttt/game'
require 'ttt/game_history'
require 'ttt/riak_db'

module TTT
  class GameBuilder
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

    def new_db(options)
      instantiate_db(options)
    end

    private
    def instantiate_db(options)
      DB.new(:port => PORT, :http_backend => HTTP_BACKEND, :bucket => options.fetch(:bucket))
    end

    def instantiate_history
      HISTORY.new
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
