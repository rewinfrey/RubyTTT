require 'cli/player_selection'
require 'cli/board_selection'
require 'cli/clio'
require 'cli/play_again'
require 'cli/cli_presenter'
require 'cli/walk_history'

module CLI
  class CLIGame
    def self.configure(context, input, output)
      @context   = context
      @presenter = CLIPresenter.new(input, output)
      self
    end

    def self.play
      process_command(@presenter.menu)
    end

    def self.process_command(selection)
      case selection.chomp
      when "1" then init_game
      when "2" then game_list
      when "3" then exit
      else
        play
      end
    end

    def self.init_game
      @presenter.welcome_prompt
      player_select   = get_player_selection
      board_select    = get_board_selection
      @game           = build_game(player_select, board_select)
      @id             = @context.add_game(@game)
      play_game
    end

    def self.get_player_selection
      PlayerSelection.new(@context.players, @presenter).process
    end

    def self.get_board_selection
      BoardSelection.new(@context.boards, @presenter).process
    end

    def self.build_game(pselect, bselect)
      @context.setup.new_game(player1: pselect.player1, player2: pselect.player2, board: bselect.board)
    end

    def self.play_game
      while @game.not_finished?
        move_cycle
      end
      walk_history
      play_again
    end

    def self.move_cycle
      @game = @context.get_game(@id)
      @presenter.player_prompt(@game.board_arr, @game.show_history, @game.current_player)
      process_next_move
    end

    def self.process_next_move
      @context.ai_move(@id) if @game.ai_move?
      move = @presenter.input if !@game.ai_move?
      if @context.valid_move?(@id, move.to_i) && !@game.ai_move?
        @context.update_game(@id, move.to_i, @game.current_player.side)
      end
      @game = @context.get_game(@id)
      eval_board_state
      play_game
    end

    def self.eval_board_state
      @presenter.process_winner(@game.board_arr, @game.show_history, @game.last_player) if @game.winner?
      @presenter.process_draw(@game.board_arr, @game.show_history)                      if @game.finished? && !@game.winner?
    end

    def self.game_list
      games = @context.game_list
      if games.length == 0
        @presenter.no_games
        sleep 2
        play
      else
        selection = @presenter.process_game_list(games)
        if @game = @context.get_game(selection.chomp)
          @id = selection.chomp
          resume_game
        else
          game_list
        end
      end
    end

    def self.select_game_prompt
      view.select_game_prompt
    end

    def self.resume_game
      @presenter.player_prompt(@game.board[], @game.show_history, @game.current_player)
      eval_board_state
      play_game
    end

    def self.game
      @game
    end

    def self.game=(args)
      @game = args
    end

    def self.presenter=(args)
      @presenter = args
    end

    def self.presenter
      @presenter
    end

    def self.context=(args)
      @context = args
    end

    def self.context
      @context
    end

    def self.play_again
      exit unless PlayAgain.new(@presenter).play_again?
      play
    end

    def self.walk_history
      @walk_history = WalkHistory.new(@presenter, @game)
      @walk_history.post_game_msg
      play_again
    end
  end
end
