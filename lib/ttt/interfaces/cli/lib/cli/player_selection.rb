require 'cli/selection'

module CLI
  class PlayerSelection < Selection
    attr_accessor :presenter, :players, :player1, :player2
    def initialize(players, presenter)
      self.presenter = presenter
      self.players   = players
    end

    def process
      process_player_type_input(1, presenter.player_type_prompt(1, players))
      process_player_type_input(2, presenter.player_type_prompt(2, players))
      self
    end

    def process_player_type_input(num, selection)
      if player_selection_valid? selection.chomp.to_i
        set_player_string(num, selection.chomp.to_i)
      else
        presenter.error
        process_player_type_input(num, presenter.player_type_prompt(num, players))
      end
    end

    def set_player_string(num, selection)
      case num
      when 1
        self.player1 = _player(selection)
      when 2
        self.player2 = _player(selection)
      end
    end

    def _player(selection)
      players[selection - 1]
    end

    def player_selection_valid?(selection)
      0 < selection.to_i && selection <= players.length
    end
  end
end
