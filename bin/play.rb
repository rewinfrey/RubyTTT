#! /usr/bin/env ruby
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../cli/lib', __FILE__)
require 'ttt/setup'
require 'cli/cli_game'

setup = TTT::Setup.new
CLI::CLIGame.play(players: setup.players,
                  boards:  setup.boards,
                  db:      setup.new_db,
                  output:  $stdout,
                  input:   $stdin)
