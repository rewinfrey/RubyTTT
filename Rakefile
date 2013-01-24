$:.unshift File.expand_path('../lib/', __FILE__)
require 'ttt/setup'
require 'rake'
require 'rake/testtask'

desc "Running Core Lib specs"
task :lib_specs do
  system 'bash -l -c "rvm use default"'
  system('rspec spec')
end

desc "Running CLI specs"
task :cli_specs do
  system 'bash -l -c "cd cli; rvm use default; rspec spec"'
end

desc "Running Rails specs"
task :rails_specs do
  system('cd rails; rake spec; cd ..')
end

desc "Running Limelight Specs"
task :limelight_specs do
  system "bash -l -c 'cd limelight; rspec spec'"
end

task :all_specs => [:lib_specs, :cli_specs, :rails_specs, :limelight_specs] do
  "Running all specs"
end

task :launch_riak do
  puts   "launching riak cluster"
  puts   "-- node 1 starting --"
  system "launchctl limit maxfiles 2048 2048; cd riak/rel; riak/bin/riak start"
  puts   "-- node 2 starting --"
  system "launchctl limit maxfiles 2048 2048; cd riak/rel; riak1/bin/riak start"
  puts   "-- node 3 starting --"
  system "launchctl limit maxfiles 2048 2048; cd riak/rel; riak2/bin/riak start"
  puts   "-- node 4 starting --"
  system "launchctl limit maxfiles 2048 2048; cd riak/rel; riak3/bin/riak start"
  puts   "-- cluster ring forming --"
  puts   "-- checking ring status --"
  system "cd riak/rel; riak/bin/riak-admin ring_status"
  puts   "-- if status is up, but ring is not ready, Riak is still configuring the ring, but the datastore is accessible"
end

task :stop_riak do
  puts   "shutting down riak cluster"
  puts   "-- stopping node 4 --"
  system "cd riak/rel; riak3/bin/riak stop"
  puts   "-- stopping node 3 --"
  system "cd riak/rel; riak2/bin/riak stop"
  puts   "-- stopping node 2 --"
  system "cd riak/rel; riak1/bin/riak stop"
  puts   "-- stopping node1 --"
  system "cd riak/rel; riak/bin/riak stop"
  puts   "all nodes stopped"
end

task :dump_riak do
  puts "cleaning up 'ttt_games' bucket"
  setup = TTT::Setup.new
  db    = setup.new_db
  db.client['ttt_games'].keys.each do |key|
    if game = db.client['ttt_games'].get(key)
      game.delete
      puts "success dumping key: #{key}"
    end
  end
end

task :riak_status do
  system('riak/rel/riak/bin/riak-admin ring_status')
end
