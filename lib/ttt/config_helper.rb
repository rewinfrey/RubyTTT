require 'ttt/configuration'

module TTT
  class ConfigHelper
    def self.player_types
      HUMAN_READABLE_PLAYERS
    end

    def self.board_types
      HUMAN_READABLE_BOARDS
    end

    def self.get_player_const(player_type)
      PLAYERS[get_player_index(player_type)]
    end

    def self.get_board_const(board_type)
      BOARDS[get_board_index(board_type)]
    end

    def self.get_player_index(player_type)
      HUMAN_READABLE_PLAYERS.index(player_type)
    end

    def self.get_board_index(board_type)
      HUMAN_READABLE_BOARDS.index(board_type)
    end
  end
end
