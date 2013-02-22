#! /usr/bin/env ruby
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path("../../lib/ttt/interfaces/cli/lib", __FILE__)
require 'ttt/setup'
require 'ttt/context'
require 'cli/cli_game'

context       = TTT::Context.instance
context.setup = TTT::Setup
CLI::CLIGame.new(context, $stdin, $stdout).play
