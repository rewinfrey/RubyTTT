ttt do
  title :text => "Main Menu"

  row

  menu_button_row do
    new_game :players => "button", :text => "New Game", :id => "new_game"
  end

  menu_button_row do
    load_game :players => "button", :text => "Load Game", :id => "load_game"
  end

  menu_button_row do
    exit_ttt :players => "button", :text => "Exit", :id => "exit"
  end
end
