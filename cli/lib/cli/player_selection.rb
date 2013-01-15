module CLI
  class PlayerSelection
    attr_accessor :view, :players, :player1, :player2
    def initialize(options)
      self.view    = options.fetch(:view)
      self.players = options.fetch(:players)
    end

    def input
      view.input
    end

    def process
      view.player_type_prompt(1, players)
      process_player_type_input(1, input)
      view.player_type_prompt(2, players)
      process_player_type_input(2, input)
      self
    end

    def player_type_prompt(num)
      view.player_type_prompt(num, @players)
    end

    def process_player_type_input(num, selection)
      if player_selection_valid? selection.chomp.to_i
        set_player_string(num, selection.chomp.to_i)
      else
        view.generic_error_msg
        view.player_type_prompt(num, players)
        process_player_type_input(num, input)
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
      return false if selection.class == Float
      0 < selection && selection <= players.length
    end
  end
end
