require 'cli/player_selection'
require 'cli/board_selection'
require 'cli/view'
require 'cli/play_again'

module CLI
  class CLIGame
    def self.play(options)
      @players  = options.fetch(:players)
      @boards   = options.fetch(:boards)
      @db       = options.fetch(:db)
      self.view = View.new(outstream: options.fetch(:output), instream: options.fetch(:input))
      menu
    end

    def self.menu
      welcome_prompt
      command_list
      process_command(@view.input)
    end

    def self.process_command(selection)
      case selection.chomp
      when "1" then init_game
      when "2" then game_list
      when "3" then exit
      else menu
      end
    end

    def self.command_list
      view.command_list
    end

    def self.game_list
      games = @db.game_list(:list_name => "ttt_game_list")
      if games.length == 0
        view.no_games_saved
        menu
      else
        view.game_list(games)
        db_list
        load_game(view.input)
      end
    end

    def self.db_list
      view.db_list
    end

    def self.welcome_prompt
      view.welcome_prompt
    end

    def self.init_game
      welcome_prompt
      pselect   = PlayerSelection.new(players: @players, view: @view).process
      bselect   = BoardSelection.new(boards: @boards, view: @view).process
      self.game = TTT::GameBuilder.new.new_game(player1: pselect.player1, player2: pselect.player2, board: bselect.board)
      @db.add_game(:list_name => "ttt_game_list", :game => game)
      @id   = @db.id
      play_game
    end

    def self.load_game(selection)
      self.game = @db.load_game(:list_name => "ttt_game_list", :id => selection.chomp)
      @view.output_help(@game.board[])
      @view.output_board(@game.board[])
      @view.player_prompt(@game.current_player)
      eval_board_state
      play_game
    end

    def self.play_game
      while @game.not_finished?
        move_cycle
        eval_board_state
        @db.save_game(:list_name => "ttt_game_list", :game => game, :id => @id)
      end
      play_again
    end

    def self.move_cycle
      @view.output_help(@game.board[])
      @view.output_board(@game.board[])
      @view.player_prompt(@game.current_player)
      process_next_move
    end

    def self.process_next_move
      if @game.ai_move?
        @game.next_move
      else
        process_human_move(@view.input)
        @game.switch_player
      end
      @db.save_game(:list_name => "ttt_game_list", :game => @game, :id => @id)
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
        @view.output_board(@game.board[])
        @view.winner_prompt @game.last_player?
      elsif @game.finished?
        @view.output_board(@game.board[])
        @view.draw_prompt
      end
    end

    def self.play_again
      exit unless PlayAgain.new(view: @view).play_again?
      play(players: @players, boards: @boards, output: $stdout, input: $stdin, db: @db)
    end
  end
end
