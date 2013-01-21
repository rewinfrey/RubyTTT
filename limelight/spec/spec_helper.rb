require 'rubygems'
require 'rspec'
require 'limelight/specs/spec_helper'

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../")

$:.unshift File.expand_path("../../../lib/", __FILE__)
$:.unshift File.expand_path("../", __FILE__)

