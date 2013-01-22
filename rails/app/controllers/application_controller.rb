class ApplicationController < ActionController::Base
  protect_from_forgery

  def build_new_game(params)
    game_builder = TTT::GameBuilder.new
    game = game_builder.new_game(player1: params[:player1], player2: params[:player2], board: params[:board])
    game
  end

  def reset_cookies
    cookies[:game_id] = nil
  end

  def player1_move?(game)
    game.current_player.side == game.player1.side
  end
end
