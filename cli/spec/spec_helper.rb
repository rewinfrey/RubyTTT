$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'simplecov'
SimpleCov.start
require 'cli/clio'
require 'cli/cli_game'
require 'cli/player_selection'
require 'cli/board_selection'
require 'ttt/setup'
require 'cli/cli_presenter'
require 'cli/selection'
require 'cli/walk_history'
