on_scene_opened do
  production.limelight_game = GamePlayscript.new(:game => production.game, :context => scene)
  production.limelight_game.process_ai_move
end
