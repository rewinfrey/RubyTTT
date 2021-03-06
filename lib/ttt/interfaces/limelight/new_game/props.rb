ttt do
  title :text => "Welcome to TTT!"

  row

  player1 :text => "Player 1"
  player_type :players => "drop_down", :id => "player1", :choices => TTT::Setup.new.players

  player2 :text => "Player 2"
  player_type :players => "drop_down", :id => "player2", :choices => TTT::Setup.new.players

  boards :text => "Boards"
  board_type :players => "drop_down", :id => "board", :choices => TTT::Setup.new.boards

  row

  setup_button_row do
    setup_button :players => "button", :id  => "setup_button", :text => "Start Game"
    main_menu :players => "button", :id => "main_menu", :text => "Main Menu"
  end
end
