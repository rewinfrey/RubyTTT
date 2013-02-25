require 'rake'

Gem::Specification.new do |s|
  s.name        = 'bashrw-ttt'
  s.version     = '0.2.2'
  s.summary     = "Ruby TTT library made for my 8th Light Apprenticeship. Contains a Command Line, Rails and Limelight interfaces."
  s.description = "See the README for instructions about setting up Riak."
  s.authors     = ["Rick Winfrey"]
  s.email       = 'rick.winfrey@gmail.com'
  s.files       = FileList["lib/**/*.rb", "bin/*", "lib/interfaces/**/*", "spec/**/*.rb", "spec/*.rb"].to_a
  s.homepage    = 'http://rubygems.org/gems/bashrw_ttt'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_runtime_dependency 'riak-client'
end
