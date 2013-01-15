$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'simplecov'
SimpleCov.start
require 'ttt/ai'
require 'ttt/player'
require 'ttt/game'
require 'ttt/board'
require 'ttt/game_history'
require 'ttt/ai_easy'
require 'ttt/ai_medium'
require 'ttt/ai_hard'
require 'ttt/four_by_four'
require 'ttt/three_by_three'
require 'ttt/three_by_three_by_three'
require 'ttt/human'
require 'ttt/riak_db'
require 'ttt/game_builder'
require 'ttt/config_helper'
