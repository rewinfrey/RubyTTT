require 'cli/player_selection'
require 'cli/board_selection'
require 'cli/clio'
require 'cli/play_again'
require 'cli/cli_presenter'
require 'cli/walk_history'

module CLI
  class CLIGame
    attr_accessor :context, :presenter, :id, :games
    def initialize(context, input, output)
      self.context = context
      self.presenter = CLIPresenter.new(input, output)
    end

    def play
      user_selection = @presenter.menu
      process_command(user_selection)
    end

    def process_command(selection)
      case selection.chomp
      when "1" then init_game
      when "2" then game_list
      when "3" then exit
      else
        play
      end
    end

    def init_game
      @presenter.welcome_prompt
      player_select   = get_player_selection
      board_select    = get_board_selection
      new_game        = build_game(player_select, board_select)
      @id             = @context.add_game(new_game)
      play_game
    end

    def get_player_selection
      PlayerSelection.new(@context.players, @presenter).process
    end

    def get_board_selection
      BoardSelection.new(@context.boards, @presenter).process
    end

    def build_game(pselect, bselect)
      @context.setup.new_game(player1: pselect.player1, player2: pselect.player2, board: bselect.board)
    end

    def play_game
      while game.not_finished?
       move_cycle
      end
      game_over
    end

    def game_over
      walk_history
      play_again
    end

    def game
      @context.get_game(@id)
    end

    def move_cycle
      cur_game = game
      player_prompt(cur_game)
      process_next_move
    end

    def player_prompt(cur_game)
      @presenter.player_prompt(cur_game.board.board, cur_game.show_history, cur_game.current_player)
    end

    def process_next_move
      if @context.ai_move?(@id)
        @context.ai_move(@id)
      else
        move = get_next_move
        if validate_move(move)
          update_move(move)
        else
          move_cycle
        end
      end
      eval_board_state
    end

    def get_next_move
      if game.ai_move?
        @context.ai_move(@id)
      else
        @presenter.input
      end
    end

    def validate_move(move)
      @context.valid_move?(@id, move.to_i)
    end

    def update_move(move)
      @context.update_game(@id, move.to_i, game.current_player.side)
    end

    def eval_board_state
      @presenter.process_winner(game.board_arr, game.show_history, game.last_player) if game.winner?
      @presenter.process_draw(game.board_arr, game.show_history)                     if game.finished? && !game.winner?
    end

    def game_list
      get_games
      if @games
        load_game
      else
        no_games
      end
    end

    def get_games
      @games = @context.game_list
      @games = nil if @games.length == 0
    end

    def no_games
      @presenter.no_games
      sleep 1
      play
    end

    def load_game
      selection = @presenter.process_game_list(@games)
      if @context.get_game(selection.chomp)
        @id = selection.chomp
        resume_game
      else
        game_list
      end
    end

    def no_games
      @presenter.no_games
      sleep 1
      play
    end

    def resume_game
      @presenter.player_prompt(game.board[], game.show_history, game.current_player)
      eval_board_state
      play_game
    end

    def game
      @context.get_game(@id)
    end

    def presenter=(args)
      @presenter = args
    end

    def presenter
      @presenter
    end

    def context=(args)
      @context = args
    end

    def context
      @context
    end

    def play_again
      exit unless PlayAgain.new(@presenter).play_again?
      play
    end

    def walk_history
      @walk_history = WalkHistory.new(@presenter, game)
      @walk_history.post_game_msg
      play_again
    end
  end
end
