#! /usr/bin/env ruby
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../cli/lib', __FILE__)
require 'ttt/game_builder'
require 'cli/cli_game'

game_builder = TTT::GameBuilder.new
CLI::CLIGame.play(players: game_builder.players,
                  boards:  game_builder.boards,
                  db:      game_builder.new_db(:bucket => "ttt_game_list"),
                  output:  $stdout,
                  input:   $stdin)
