$:.unshift File.expand_path('../lib/', __FILE__)
require 'ttt/setup'
require 'rake'
require 'rake/testtask'

task :start do
  system "clear"
  puts "Running all specs..."
end

desc "Running Core Lib specs"
task :lib_specs do
  puts "\nRunning Lib specs"
  system 'bundle exec rspec spec'
end

desc "Running CLI specs"
task :cli_specs do
  system "clear"
  puts "Running CLI specs"
  system "bash -l -c 'cd lib/ttt/interfaces/cli; bundle exec rspec spec'"
  puts
end

desc "Running Rails specs"
task :rails_specs do
  system "clear"
  puts "Running Rails specs"
  system "bash -l -c 'cd lib/ttt/interfaces/rails; bundle exec rake db:migrate; bundle exec rspec spec'"
end

desc "Running Limelight Specs"
task :limelight_specs do
  puts "Running Limelight specs"
  system "bash -l -c 'cd lib/ttt/interfaces/limelight; bundle exec rspec spec'"
end

task :all_specs => [:start, :lib_specs, :cli_specs, :rails_specs, :limelight_specs] do
end

task :launch_riak do
  puts   "launching riak cluster"
  puts   "-- node 1 starting --"
  system "launchctl limit maxfiles 2048 2048; cd ~/riak-1.2.1/dev; dev1/bin/riak start"
  puts   "-- node 2 starting --"
  system "launchctl limit maxfiles 2048 2048; cd ~/riak-1.2.1/dev; dev2/bin/riak start"
  puts   "-- node 3 starting --"
  system "launchctl limit maxfiles 2048 2048; cd ~/riak-1.2.1/dev; dev3/bin/riak start"
  puts   "-- node 4 starting --"
  system "launchctl limit maxfiles 2048 2048; cd ~/riak-1.2.1/dev; dev4/bin/riak start"
  puts   "-- cluster ring forming --"
  puts   "-- checking ring status --"
  system "cd ~/riak-1.2.1/dev; dev1/bin/riak-admin ring_status"
  puts   "-- if status is up, but ring is not ready, Riak is still configuring the ring, but the datastore is accessible"
end

task :stop_riak do
  puts   "shutting down riak cluster"
  puts   "-- stopping node 4 --"
  system "cd ~/riak-1.2.1/dev; dev1/bin/riak stop"
  puts   "-- stopping node 3 --"
  system "cd ~/riak-1.2.1/dev; dev2/bin/riak stop"
  puts   "-- stopping node 2 --"
  system "cd ~/riak-1.2.1/dev; dev3/bin/riak stop"
  puts   "-- stopping node1 --"
  system "cd ~/riak-1.2.1/dev; dev4/bin/riak stop"
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
  system('~/riak-1.2.1/dev/dev1/riak/bin/riak-admin ring_status')
end
