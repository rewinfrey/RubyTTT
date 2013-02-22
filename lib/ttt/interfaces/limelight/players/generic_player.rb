on_scene_opened do
  production.limelight_game = GamePlayscript.new(:game_id => production.game_id, :context => scene, :production => production)
  if production.context.finished?(production.game_id)
    production.limelight_game.display_results
  else
    production.limelight_game.process_ai_move
  end
end
