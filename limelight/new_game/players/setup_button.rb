on_button_pushed do
  game_builder    = TTT::GameBuilder.new
  production.game = game_builder.new_game(:player1 => player1, :player2 => player2, :board => board)
  production.open_scene(production.game.which_board?)
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
