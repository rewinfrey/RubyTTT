require 'spec_helper'

describe TttGamesController do
  let(:context)       { TTT::Context.instance }
  let(:setup)         { TTT::Setup.new }
  let(:players)       { setup.players }
  let(:boards)        { setup.boards  }
  let(:game)          { setup.new_game(player1: players.first, player2: players.first, board: boards.first) }

  describe "GET new" do
    it "gets the player types defined by the TTT library" do
      get :new
      assigns[:players].should == players
    end

    it "gets the board types defined by the TTT library" do
      get :new
      assigns[:boards].should == boards
    end

    it "sets cookies to nil" do
      get :new
      @request.cookies[:game_id].should == nil
      @request.cookies[:move_index].should == nil
    end
  end

  describe "POST create_game" do
    before(:each) do
      post :create_game, player1: "Human", player2: "Human", board: "3x3"
    end

    it "sets the cookies[:game_id] to the new game stored in the db" do
      response.cookies["game_id"].should_not be_nil
    end

    it "sets the flash[:notice] to 'Welcome to TTT!'" do
      flash[:notice].should == "Welcome to Tic Tac Toe!"
    end
  end

  describe "GET show" do
    before(:each) do
      @id = context.add_game(game)
      request.cookies["game_id"] = @id
      @game = context.get_game(@id)
    end

    it "has the correct game_id in cookies" do
      get :show
      cookies["game_id"].should == @id
    end

    it "loads the game whose id is the id stored as cookies[:game_id] from the database" do
      get :show
      assigns[:game].eql? @game
    end

    it "creates a web game presenter responsible for displaying the game board" do
      get :show
      assigns[:web_game_presenter].should_not be_nil
      assigns[:web_game_presenter].id.should == @id
    end
  end

  describe "POST update_game" do
    before(:each) do
      @id = context.add_game(game)
      @game = context.get_game(@id)
      post :update_game, :id => @id, :game_id => @id, :move => 0
    end

    it "updates cookies[:game_id] with the updated game's id" do
      @response.cookies['game_id'].should == @id
    end

    it "saves the game to the db" do
      updated_game = context.get_game(@id)
      @game.board.should_not == updated_game.board
    end
  end


  describe "GET game_list" do
    it "returns all game ids for the queried bucket" do
      @games = context.game_list()
      @total_keys = @games.length
      get :game_list
      assigns[:games].length.should == @total_keys
    end
  end

  describe "GET get_game" do
    it "reassigns the cookies[:game_id] to the selected game" do
      get :get_game, id: 1
      cookies[:game_id].should == "1"
    end
  end
end
