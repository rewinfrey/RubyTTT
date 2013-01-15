$:.unshift File.expand_path("../../lib", __FILE__)
$:.unshift File.dirname(__FILE__)

require "playscripts/game_playscript"
require 'ttt/game'
require 'ttt/game_builder'

on_production_loaded do
  backstage_pass :game
  backstage_pass :limelight_game
  backstage_pass :game_builder
end
