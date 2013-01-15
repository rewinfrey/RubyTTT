title_history_partial do
  __ :name => "ttt"
  title :text => "#{@text} Tic Tac Toe"

  player_turn :text => "Player 1 turn", :id => "player_turn"

  move_history :text => "Move History", :id => "move_history"
  __install "partials/board_partial.rb"
end
