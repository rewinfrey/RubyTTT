require 'spec_helper'

describe GameController do
  let(:game_builder)  { TTT::GameBuilder.new }
  let(:players)       { game_builder.players }
  let(:boards)        { game_builder.boards  }
  let(:game)          { game_builder.new_game(player1: players.first, player2: players.first, board: boards.first) }
  let(:ai_game)       { game_builder.new_game(player1: players.second, player2: players.second, board: boards.first) }
  let(:db)            { game_builder.new_db(bucket: "rails_ttt_list") }
  let(:list_name)     { "rails_ttt_list" }

  describe "GET new" do
    it "gets the player types defined by the TTT library" do
      get :new
      assigns[:player_options].should == players
    end

    it "gets the board types defined by the TTT library" do
      get :new
      assigns[:board_options].should == boards
    end
  end

  describe "POST create_game" do
    before(:each) do
      post :create_game, player1: "Human", player2: "Human", board: "3x3"
    end

    it "sets the cookies[:game_id] to the new game stored in the db" do
      response.cookies["game_id"].should_not be_nil
    end

    it "sets the cookies[:move_index] to 0" do
      response.cookies["move_index"].should == "0"
    end

    it "sets the flash[:notice] to 'Welcome to TTT!'" do
      flash[:notice].should == "Welcome to TTT!"
    end
  end

  describe "GET show" do
    before(:each) do
      @id = db.add_game(list_name: list_name, game: game)
      request.cookies["game_id"] = @id
      @game = db.load_game(id: @id, list_name: list_name)
      request.cookies["move_index"] = @game.show_history.length
    end

    it "has the correct game_id in cookies" do
      get :show
      cookies["game_id"].should == @id
    end

    it "loads the game whose id is the id stored as cookies[:game_id] from the database" do
      get :show
      assigns[:game].board[].should       == @game.board[]
      assigns[:game].player1.class.should == @game.player1.class
      assigns[:game].player2.class.should == @game.player2.class
      assigns[:game].show_history.should  == @game.show_history
    end

    it "creates a web game presenter responsible for displaying the game board" do
      get :show
      assigns[:web_game_presenter].should_not be_nil
      assigns[:web_game_presenter].id.should == @id
    end

    it "determines move index from the cookie" do
      get :show
      assigns[:move_index].should == cookies[:move_index]
    end
  end

  describe "POST mark_move" do
    before(:each) do
      @id = db.add_game(list_name: list_name, game: game)
      request.cookies["game_id"] = @id
      @game = db.load_game(id: @id, list_name: list_name)
      @pre_move_board = @game.board[]
      post :mark_move, move: "1", id: @id
    end

    it "updates the board with the move" do
      assigns[:game].board[].should_not == @pre_move_board
    end

    it "saves the game to the db" do
      assigns[:game].board[].should == db.load_game(list_name: list_name, id: @id).board[]
    end

    it "switches the game's current player" do
      assigns[:game].current_player.side.should_not == @game.current_player.side
    end
  end

  describe "POST computer_move" do
    before(:each) do
      @id = db.add_game(list_name: list_name, game: ai_game)
      @game = db.load_game(list_name: list_name, id: @id)
      request.cookies["move_index"] = 0
      post :computer_move, id: @id
    end

    it "finds the game in the db" do
      assigns[:game].player1.class.should == @game.player1.class
      assigns[:game].player2.class.should == @game.player2.class
      assigns[:game].board.class.should == @game.board.class
    end

    it "increments the move index" do
      cookies["move_index"].should == 1
    end
  end

  describe "GET game_index" do
    it "returns all game ids for the queried bucket" do
      @games = db.game_list(list_name: list_name)
      @total_keys = @games.length
      get :game_index
      assigns[:games].length.should == @total_keys
    end
  end

  describe "GET load_game" do
    it "reassigns the cookies[:game_id] to the selected game" do
      get :load_game, id: 1
      cookies[:game_id].should == "1"
    end

    it "makes an array of GameStruct objects (ids, status)" do
      pending()
    end

    it "determines a temp_game's status?" do
      pending()
    end
  end
end
