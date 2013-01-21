require 'cli/player_selection'
require 'cli/board_selection'
require 'cli/io'
require 'cli/play_again'
require 'cli/cli_presenter'

module CLI
  class CLIGame
    def self.play(options)
      @players   = options.fetch(:players)
      @boards    = options.fetch(:boards)
      @db        = options.fetch(:db)
      @presenter = CLIPresenter.new(options.fetch(:input), options.fetch(:output))
      @presenter.menu
      process_command(@presenter.input)
    end

    def self.process_command(selection)
      case selection.chomp
      when "1" then init_game
      when "2" then game_list
      when "3" then exit
      else
        @presenter.menu
        process_command(@presenter.input)
      end
    end

    def self.game_list
      games = @db.game_list
      if games.length == 0
        @presenter.no_games
      else
        view.game_list(games)
        view.select_game_prompt
        load_game(view.input)
      end
    end

    def self.select_game_prompt
      view.select_game_prompt
    end

    def self.welcome_prompt
      view.welcome_prompt
    end

    def self.init_game
      @presenter.welcome_prompt
      pselect   = PlayerSelection.new(players: @players, presenter: @presenter).process
      bselect   = BoardSelection.new(boards: @boards, presenter: @presenter).process
      self.game = TTT::Setup.new.new_game(player1: pselect.player1, player2: pselect.player2, board: bselect.board)
      @id = @db.add_game(game)
      play_game
    end

    def self.load_game(selection)
      self.game = @db.load_game(selection.chomp)
      @presenter.output_help(@game.board[])
      @presenter.output_board(@game.board[])
      @presenter.player_prompt(@game.current_player)
      eval_board_state
      play_game
    end

    def self.play_game
      while @game.not_finished?
        move_cycle
        eval_board_state
        @db.save_game(@id, game)
      end
      play_again
    end

    def self.move_cycle
      @presenter.output_help(@game.board[])
      @presenter.output_board(@game.board[])
      @presenter.player_prompt(@game.current_player)
      process_next_move
    end

    def self.process_next_move
      if @game.ai_move?
        @game.next_move
      else
        process_human_move(@presenter.input)
        @game.switch_player
      end
      @db.save_game(@id, @game)
    end

    def self.game
      @game
    end

    def self.game=(args)
      @game = args
    end

    def self.view
      @view
    end

    def self.view=(args)
      @view = args
    end

    def self.process_human_move(input)
      @game.mark_move(input.to_i)
      @game.record_move(input.to_i)
    end

    def self.eval_board_state
      if @game.winner?
        @presenter.output_board(@game.board[])
        @presenter.winner_prompt @game.last_player?
      elsif @game.finished?
        @presenter.output_board(@game.board[])
        @presenter.draw_prompt
      end
    end

    def self.play_again
      exit unless PlayAgain.new(presenter: @presenter).play_again?
      play(players: @players, boards: @boards, output: $stdout, input: $stdin, db: @db)
    end
  end
end
