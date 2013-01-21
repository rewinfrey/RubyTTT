require 'ttt/game'
require 'ttt/game_builder'

class WebGamesController < ApplicationController

  def new
    game_builder    = TTT::GameBuilder.new
    @player_options = game_builder.players
    @board_options  = game_builder.boards
  end

  def create
    web_game = WebGame.new(game: build_new_game(params))
    if web_game.save
      cookies[:game_id] = web_game.id
      flash[:notice]    = "Welcome to TTT!"
      redirect_to web_game
    else
      flash[:error]     = "Oops, something went wrong, please try again."
      redirect_to action: "new"
    end
  end

  def index
    if cookies[:game_id]
      @webgame = WebGame.find_by_id(cookies[:game_id])
      redirect_to WebGame.find_by_id(cookies[:game_id])
    else
      cookies[:game_id] = nil
      redirect_to action: "new"
    end
  end

  def computer_move
    @web_game = WebGame.find_by_id(params[:id])
    next_move
    determine_result if @web_game.finished?
    redirect_to @web_game
  end

  def mark_move
    @web_game = WebGame.find_by_id(params[:id])
    @web_game.process_move(params[:move].to_i) if params[:move] && @web_game.valid_move?(params[:move].to_i)
    WebGameHistory.create!(web_game: @web_game, web_game_id: @web_game.id, move: params[:move], player: last_player?)
    determine_result if @web_game.finished?
    redirect_to @web_game
  end

  def show
    @web_game           = WebGame.find_by_id(params[:id])
    @web_game_history   = @web_game.web_game_histories
    flash[:notice]      = determine_notice
    @web_game_presenter = WebGamePresenter.for(board: @web_game.game.board, id: @web_game.id)
  end

  private

  def determine_result
    if @web_game.winner?
      @web_game.winner = @web_game.who_is_winner?
    else
      flash[:notice] = "It's a draw"
    end
    reset_cookies
    @web_game.save
  end

  def determine_notice
    if @web_game.winner?
      "#{@web_game.who_is_winner?} is the winner!"
    elsif @web_game.finished?
      "It's a draw"
    else
      player1_move?(@web_game.game) ? "Player 1 turn" : "Player 2 turn"
    end
  end

  def next_move
    move = @web_game.game.next_move
    @web_game.save
    WebGameHistory.create!(web_game: @web_game, web_game_id: @web_game.id, player: last_player?, move: move)
  end

    def last_player?
    if @web_game.game.current_player.side == "x"
      "Player 2"
    else
      "Player 1"
    end
  end
end
