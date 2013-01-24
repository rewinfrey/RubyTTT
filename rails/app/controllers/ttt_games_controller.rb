require 'ttt/setup'
require 'ttt/context'

class TttGamesController < ApplicationController
  before_filter :set_context

  def new
    cookies[:game_id]    = nil
    cookies[:move_index] = nil
    @players = @context.players
    @boards  = @context.boards
  end

  def create_game
    game              = @context.setup.new_game(player1: params[:player1], player2: params[:player2], board: params[:board])
    cookies[:game_id] = @context.add_game(game)
    flash[:notice]    = "Welcome to Tic Tac Toe!"
    redirect_to :action => "show"
  end

  def show
    @game               = @context.get_game(cookies[:game_id])
    @web_game_presenter = WebGamePresenter.for(board: @game.board, id: cookies[:game_id])
    @web_game_history   = @context.get_history(cookies[:game_id])
    @id                 = cookies[:game_id]
    flash[:notice], view_file = TttGame.process_game(cookies[:game_id], @context)
    render view_file
  end

  def game_list
    @games              = @context.game_list
  end

  def get_game
    cookies[:game_id]    = params[:id]
    redirect_to :action => "show"
  end

  def move_history
    @game               = @context.get_game(params[:id])
    cookies[:game_id]   = params[:id] if @game
    @web_game_history   = @context.get_history(cookies[:game_id])
    @id                 = params[:id]

    max_length          = TttGame.get_history_max_length(@game)

    adjust_move_index_pointers(params[:index_diff].to_i, max_length)

    history_board       = TttGame.get_history_board(@game, cookies[:move_index])

    @web_game_presenter = WebGamePresenter.for(board: history_board, id: cookies[:game_id])
    cookies[:last_id]   = cookies[:game_id]
    flash[:notice], view_file = TttGame.process_game(cookies[:game_id], @context)
    render view_file
  end

  def update_game
    @game = @context.get_game(params[:id])
    @context.update_game(params[:id], params[:move], @game.current_player.side)
    cookies[:game_id]   = params[:id]
    redirect_to :action => "show"
  end

  def next_move
    @context.ai_move(cookies[:game_id])
    redirect_to :action => "show"
  end

  private
  def adjust_move_index_pointers(index_diff, max_length)
    if cookies[:game_id] == cookies[:last_id]
      cur_index = cookies[:move_index].to_i
      temp_index = cur_index + index_diff
      cur_index += index_diff if((max_length - temp_index.abs >= 0) && (temp_index <= 0))
      cookies[:move_index] = cur_index
    else
      cookies[:move_index] = index_diff.to_i
    end
  end

  def set_context
    @context       = TTT::Context.instance
    @context.setup = TTT::Setup
  end
end
