on_button_pushed do
  context = TTT::Context.instance
  context.setup = TTT::Setup
  production.context = context
  production.game_id = scene.find("game_list").text
  require "pry"
  binding.pry
  if production.context.finished?(production.game_id)
    scene_to_load = production.context.which_board(production.game_id) + "_finished"
    production.open_scene(scene_to_load)
  end
end
