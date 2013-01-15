class CurrentPlayerPresenter
  def initialize(options)
    self.current_player = options.fetch(:current_player)
  end

  def ai_player?
    result = false
    result = true if current_player.class.to_s =~ (/ai/i)
    result
  end

  def player_number
    result = 1
    result = 2 if current_player.side == "o"
    result
  end

  private
  attr_accessor :current_player
end
