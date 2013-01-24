Railsttt::Application.routes.draw do
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
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
