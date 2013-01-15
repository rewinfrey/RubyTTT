require 'rake'
require 'rake/testtask'

desc "Running Core Lib specs"
task :lib_specs do
  system 'bash -l -c "rvm use default"'
  system('rspec spec')
end

desc "Running Rails specs"
task :rails_specs do
  system('cd rails; rake spec; cd ..')
end

desc "Running Limelight Specs"
task :limelight_specs do
  system "bash -l -c 'cd limelight; rspec spec'"
end

task :all_specs => [:lib_specs, :rails_specs, :limelight_specs] do
  "Running all specs"
end
