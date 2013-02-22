on_scene_opened do
  production.limelight_game = GamePlayscript.new(:game_id => production.game_id, :context => scene, :production => production)
  production.limelight_game.initialize_history
  production.limelight_game.display_results
end
