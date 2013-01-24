ttt do
  title :text => "Game Loader"

  row

  menu_button_row do
    game_list :text => "Select a game:"
    game_list_dropwdown :players => "drop_down", :id => "game_list", :choices => TTT::Context.game_list
  end

  row

  setup_button_row do
    load_button :players => "button", :id => "load_button", :text => "Load Game"
    main_menu   :players => "button", :id => "main_menu", :text => "Main Menu"
  end
end
