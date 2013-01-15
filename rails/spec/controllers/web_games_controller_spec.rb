require 'spec_helper'

describe WebGamesController do
  let(:game_builder) { TTT::GameBuilder.new }
  let(:players)      { game_builder.players }
  let(:boards)       { game_builder.boards  }
  let(:game)         { game_builder.new_game(board: boards.first, player1: players.first, player2: players.first) }
  let(:ai_game)      { game_builder.new_game(board: boards.first, player1: players.last,  player2: players.last)  }

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

  describe "POST create" do
    before(:each) do
      @web_game = mock_model(WebGame)
    end

    it "creates a new web game" do
      @web_game.stub(:save).and_return(true)
      @web_game.stub(:id).and_return(1)
      WebGame.should_receive(:new).and_return(@web_game)
      post :create, player1: "Human", player2: "Human", board: "3x3"
    end

    context "after instantiating a new web game" do
      before(:each) do
        WebGame.should_receive(:new).and_return(@web_game)
        @web_game.stub(:id).and_return(1)
      end

      context "and the save is successful" do
        before(:each) do
          @web_game.should_receive(:save).and_return(true)
        end

        it "saves the web game" do
          post :create, player1: "Human", player2: "Human", board: "3x3"
        end

        it "sets cookies[:game_id] to web_game.id" do
          post :create, player1: "Human", player2: "Human", board: "3x3"
          cookies[:game_id].should == @web_game.id
        end

        it "redirects to the web_game's show page" do
          post :create, player1: "Human", player2: "Human", board: "3x3"
          redirect_to @web_game
        end
      end

      context "and the save is unsuccessful" do
        before(:each) do
          @web_game.should_receive(:save).and_return(false)
          post :create, player1: "Human", player2: "Human", board: "3x3"
        end

        it "sets flash[error]" do
          flash[:error].should_not == ""
        end

        it "redirects to 'new'" do
          redirect_to action: "new"
        end
      end
    end
  end

  describe "GET index" do
    it "redirects the user to a previously started game if one is found in the cookies" do
      web_game      = WebGame.new(game: game)
      web_game.save
      cookies[:game_id] = web_game.id
      get :index
      redirect_to WebGame.find_by_id(cookies[:game_id])
    end

    it "redirects the user to new if no game_id is found in cookies" do
      get :index
      redirect_to action: "new"
    end

    it "redirects the user to index if no game_id is found in cookies" do
      get :index
      redirect_to action: "index"
    end
  end

  describe "PUT mark_move" do
    before(:each) do
      @web_game = WebGame.new(game: game)
      @web_game.game.player1.side = "x"
      @web_game.game.player2.side = "o"
      @web_game.save
    end

    it "finds the existing game in the db" do
      put :mark_move, id: @web_game.id
      response.should redirect_to @web_game
    end

    context "a valid move is sent" do
      it "marks the board with the move" do
        put :mark_move, { id: @web_game.id, move: "0" }
        assigns(:web_game).game.board.board[0].should_not == " "
      end

      it "switches the current player" do
        put :mark_move, { id: @web_game.id, move: "0" }
        assigns(:web_game).game.current_player.side.should == "o"
      end
    end

    context "an invalid move is sent" do
      before(:each) do
        @web_game.game.board.board[0] = "x"
        put :mark_move, { id: @web_game.id, move: "0" }
      end

      it "does not switch the current player" do
        assigns(:web_game).game.current_player.side == @web_game.game.player1.side
      end

      it "redirects to the show page and prompts for the move again" do
        response.should redirect_to @web_game
      end
    end
  end

  describe "GET show" do
    before(:each) do
      @web_game = WebGame.new(game: game)
      @web_game.save
    end

    it "sends a flash message prompting the current player to move" do
      get :show, id: @web_game.id
      flash[:notice].should == "Player 1 turn"
    end
  end

  describe "GET computer_move" do
    before(:each) do
      @web_game = WebGame.new(game: ai_game)
      @web_game.save
    end

    it "gets the next move from the AI" do
      get :computer_move, { id: @web_game.id }
      assigns(:web_game).game.board.board.include? "x"
      get :computer_move, { id: @web_game.id }
      assigns(:web_game).game.board.board.include? "o"
    end
  end
end
