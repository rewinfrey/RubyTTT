$:.unshift File.expand_path("../../../../", __FILE__)
$:.unshift File.dirname(__FILE__)

require 'rubygems'
require "playscripts/game_playscript"
require 'ttt/setup'
require 'ttt/context'

on_production_loaded do
  backstage_pass :context
  backstage_pass :game_id
  backstage_pass :limelight_game
  backstage_pass :move_index
end
