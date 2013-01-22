on_button_pushed do
  production.game_id = production.context.create_game(player1, player2, board)
  production.open_scene(board_const(production.context.which_board(production.game_id)))
end

private
def player1
  @player1 ||= player(1)
end

def player2
  @player2 ||= player(2)
end

def player(num)
  scene.find("player#{num}").drop_down.value
end

def board
  scene.find("board").drop_down.value
end

def board_const(arg)
  case arg
  when "three_by_three"          then "ThreeByThree"
  when "four_by_four"            then "FourByFour"
  when "three_by_three_by_three" then "ThreeByThreeByThree"
  end
end
