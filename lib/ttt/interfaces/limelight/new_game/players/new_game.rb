on_scene_opened do
  context            = TTT::Context.instance
  context.setup      = TTT::Setup
  production.context = context
end
