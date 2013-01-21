require 'ttt/config_options'

module TTT
  class ConfigHelper
    def self.player_types
      ConfigOptions::HUMAN_READABLE_PLAYERS
    end

    def self.board_types
      ConfigOptions::HUMAN_READABLE_BOARDS
    end

    def self.bucket
      ConfigOptions::BUCKET
    end

    def self.port
      ConfigOptions::PORT
    end

    def self.http_backend
      ConfigOptions::HTTP_BACKEND
    end

    def self.get_player_const(player_type)
      ConfigOptions::PLAYERS[get_player_index(player_type)]
    end

    def self.get_board_const(board_type)
      ConfigOptions::BOARDS[get_board_index(board_type)]
    end

    def self.get_player_index(player_type)
      ConfigOptions::HUMAN_READABLE_PLAYERS.index(player_type)
    end

    def self.get_board_index(board_type)
      ConfigOptions::HUMAN_READABLE_BOARDS.index(board_type)
    end

    def self.get_db_const
      ConfigOptions::DB
    end

    def self.get_history_const
      ConfigOptions::HISTORY
    end

    def self.get_game_interactor_const
      ConfigOptions::INTERACTOR
    end
  end
end
