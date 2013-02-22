Railsttt::Application.routes.draw do
  root :to => 'ttt_games#welcome'

  resources :ttt_games do
    collection do
      post 'create_game'
      get  'show'
      get  'game_list'
    end
    member do
      post 'update_game'
      get  'next_move'
      get  'load_game'
      get  'move_history'
      get  'get_game'
    end
  end

  resources :game do
    collection do
      get  'game_index'
      post 'create_game'
      get  'show'
    end
    member do
      post 'mark_move'
      get  'computer_move'
      get  'next_history_move'
      get  'load_game'
    end
  end

  resources :web_games do
   collection do
      put  'setup'
    end
    member do
      put 'player1_setup'
      put 'player2_setup'
      put 'board_selection'
      get 'test_show'
      get 'determine_next_move'
      get 'end_game'
      get 'computer_move'
      post 'mark_move'
      post 'create'
    end
  end
end
