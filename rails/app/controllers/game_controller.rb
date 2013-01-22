require 'ttt/game'

class GameController < ApplicationController

  def new
    setup           = Context.setup
    @player_options = setup.players
    @board_options  = setup.boards
  end

  def create_game
    db                   = new_db
    game                 = build_new_game(params)
    cookies[:game_id]    = db.add_game(game: game, list_name: "rails_ttt_list")
    flash[:notice]       = "Welcome to TTT!"
    cookies[:move_index] = 0
    redirect_to action: "show"
  end

  def show
    db                  = new_db
    @game               = db.load_game(id: cookies[:game_id].to_s, list_name: "rails_ttt_list")
    @id                 = cookies[:game_id]
    @web_game_presenter = WebGamePresenter.for(board: @game.board, id: @id, core: true)
    @move_index         = cookies[:move_index]
    flash[:notice]      = determine_notice
    render "show"
  end

  def mark_move
    db    = new_db
    @game = db.load_game(id: params[:id].to_s, list_name: "rails_ttt_list")
    @game.mark_move(params[:move].to_i) if params[:move] && @game.valid_move?(params[:move].to_i)
    @game.record_move(params[:move].to_i) if params[:move] && @game.valid_move?(params[:move].to_i)
    cookies[:move_index] = cookies[:move_index].to_i + 1
    @game.switch_player
    db.save_game(list_name: "rails_ttt_list", id: cookies[:game_id])
    determine_result if @game.finished?
    redirect_to action: "show"
  end

  def computer_move
    db    = new_db
    @game = db.load_game(id: params[:id], list_name: "rails_ttt_list")
    @game.next_move
    cookies[:move_index] += 1
    db.save_game(id: params[:id], list_name: "rails_ttt_list", game: @game)
    determine_result if @game.finished?
    redirect_to action: "show"
  end

  def game_index
    db     = new_db
    @keys  = db.game_list(list_name: "rails_ttt_list")
    #@games = []
    ### make struct, write status?
    #@keys.each do |key|
    #  game_record = GameStruct.new(key, temp_game.status?)
    #  temp_game = db.load_game(id: key, list_name: "rails_ttt_list")
    #  status = temp_game.status?
    #  id     = key
    #  @games << Struct.new(
    #end

  end

  def load_game
    cookies[:game_id] = params[:id]
    redirect_to action: "show"
  end

  def next_history_move
    db           = new_db
    @game        = db.load_game(id: params[:id].to_s, list_name: "rails_ttt_list")
    move_history = @game.show_history
    if cookies[:move_index] != move_history.length
      @game.board[] = Array.new(@game.board[].length, " ")
      move_history.slice(0, params[:move_index].to_i).each do |move|
        @game.mark_move(move.move, move.side)
        @game.switch_player
      end
      cookies[:move_index] = params[:move_index]
    end
    @id          = params[:id]
    @web_game_presenter = WebGamePresenter.for(board: @game.board, id: @id, core: true)
    @move_index         = cookies[:move_index]
    flash[:notice]      = determine_notice
    render "show"
  end

  private
  def new_db
    TTT::GameBuilder.new.new_db()
  end

  def determine_result
    if @game.winner?
      @game.switch_player
      @winner = @game.current_player
    else
      flash[:notice] = "It's a draw"
    end
    db = new_db
    db.save_game(game: @game, list_name: "rails_ttt_list", id: cookies[:game_id])
  end

  def determine_notice
    if @game.winner?
      "#{determine_winner} is the winner!"
    elsif @game.finished?
      "It's a draw"
    else
      player1_move?(@game) ? "Player 1 turn" : "Player 2 turn"
    end
  end

  def determine_winner
    @game.which_current_player?
  end
end
