ENV["RAILS_ENV"] ||= 'test'
#require 'simplecov'
#SimpleCov.start
require File.expand_path("../../config/environment", __FILE__)
$:.unshift File.expand_path("../../../../..", __FILE__)
#$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'lib'))

require 'rspec/rails'
require 'rspec/autorun'
require 'ttt/context'
require 'ttt/setup'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
