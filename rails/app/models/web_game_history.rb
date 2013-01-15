class WebGameHistory < ActiveRecord::Base
  attr_accessible :web_game, :web_game_id, :player, :move
  serialize :web_game

end
