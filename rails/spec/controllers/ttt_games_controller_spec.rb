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

  describe "GET move_history" do
    before(:each) do
      post :create_game, player1: "Human", player2: "Human", board: "3x3"
      @id = cookies[:game_id]
      post :update_game, id: @id, move: 0 # x moves at square 0 ['x', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      post :update_game, id: @id, move: 1 # o moves at square 1 ['x', 'o', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      post :update_game, id: @id, move: 4 # x moves at square 2 ['x', 'o', ' ', ' ', 'x', ' ', ' ', ' ', ' ']
      post :update_game, id: @id, move: 5 # x moves at square 2 ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', ' ']
      post :update_game, id: @id, move: 8 # x moves at square 2 ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', 'x']
    end

    context "gets the board for a particular game's move history for a given place in history" do
      it "returns the final game board state when index diff is 0 and it is the first time the game history is requested" do
        get :move_history, id: @id, index_diff: 0
        cookies[:game_id].should == @id
        assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', 'x']
      end

      it "allows the user to traverse backwards through a game's history one step at a time" do
        5.times do |n|
          request.cookies[:move_index] = -(n)
          request.cookies[:last_id] = @id
          get :move_history, id: @id, index_diff: -1
          cookies[:game_id].should == @id
          case n
          when 0 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', ' ']
          when 1 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', 'x', ' ', ' ', ' ', ' ']
          when 2 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          when 3 then assigns[:web_game_presenter].board.board.should ==  ['x', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          when 4 then assigns[:web_game_presenter].board.board.should ==  [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          end
        end
      end

      it "allows the user to traverse forwards through a game's history one step at a time" do
        5.times do |n|
          request.cookies[:move_index] = n + -5
          request.cookies[:last_id] = @id
          get :move_history, id: @id, index_diff: 1
          cookies[:game_id].should == @id
          case n
          when 0 then assigns[:web_game_presenter].board.board.should ==  ['x', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          when 1 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          when 2 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', 'x', ' ', ' ', ' ', ' ']
          when 3 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', ' ']
          when 4 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', 'x']
          end
        end
      end

      it "doesn't all the user to traverse backwards further than the start of the game" do
        50.times do |n|
          if n < 6
            request.cookies[:move_index] = -(n)
          else
            request.cookies[:moe_index] = -5
          end
          request.cookies[:last_id] = @id
          get :move_history, id: @id, index_diff: -1
          cookies[:game_id].should == @id
          case n
          when 0 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', ' ']
          when 1 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', 'x', ' ', ' ', ' ', ' ']
          when 2 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          when 3 then assigns[:web_game_presenter].board.board.should ==  ['x', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          when 4 then assigns[:web_game_presenter].board.board.should ==  [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          else
           assigns[:web_game_presenter].board.board.should ==  [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          end
        end
      end

      it "doesn't allow the user to traverse forwards further than the final state of the game" do
        50.times do |n|
          if n < 6
            request.cookies[:move_index] = n + -5
          else
            request.cookies[:move_index] = 0
          end
          request.cookies[:last_id] = @id
          get :move_history, id: @id, index_diff: 1
          cookies[:game_id].should == @id
          case n
          when 0 then assigns[:web_game_presenter].board.board.should ==  ['x', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          when 1 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
          when 2 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', 'x', ' ', ' ', ' ', ' ']
          when 3 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', ' ']
          when 4 then assigns[:web_game_presenter].board.board.should ==  ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', 'x']
          else
            assigns[:web_game_presenter].board.board.should == ['x', 'o', ' ', ' ', 'x', 'o', ' ', ' ', 'x']
          end
        end
      end
    end

    describe "#next_move" do
      before(:each) do
        post :create_game, player1: "AI Easy", player2: "AI Easy", board: "3x3"
        @id = cookies[:game_id]
      end

      it "correctly finds the current game and prompts the AI player for the next move" do
        original_game = context.get_game(@id)
        original_game.board.board.should == Array.new(9, " ")
        request.cookies[:game_id] = @id
        get :next_move, id: @id
        next_game_state = context.get_game(@id)
        next_game_state.board.board.should_not == original_game.board.board
      end
    end
  end
end
