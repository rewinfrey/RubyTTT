#require '/Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/gems/1.9.1/gems/riak-client-1.1.0/lib/riak'
require 'riak' # !> setting Encoding.default_internal

client = Riak::Client.new(:http_port => 8091, :http_backend => :Excon)

first_game = client['games'].get_or_new("first_game") # => #<Riak::RObject {games,first_game} [#<Riak::RContent [application/json]:nil>]>
first_game.data = {
                     :game => Object.new,
                     :id   => 1
                   }

first_game.store
# ~> 	from -:2:in `<main>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:4:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36: warning: loading in progress, circular require considered harmful - /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb
# ~> 	from -:2:in `<main>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:11:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend.rb:6:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36: warning: loading in progress, circular require considered harmful - /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb
# ~> 	from -:2:in `<main>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:11:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend.rb:7:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/bucket.rb:2:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/rcontent.rb:54: warning: method redefined; discarding old indexes=
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36: warning: loading in progress, circular require considered harmful - /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/bucket.rb
# ~> 	from -:2:in `<main>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:11:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend.rb:7:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/bucket.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/robject.rb:6:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36: warning: loading in progress, circular require considered harmful - /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb
# ~> 	from -:2:in `<main>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:11:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend.rb:7:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/bucket.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/robject.rb:7:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:4:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/walk_spec.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:24: warning: method redefined; discarding old bucket=
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:24: warning: method redefined; discarding old key=
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36: warning: loading in progress, circular require considered harmful - /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb
# ~> 	from -:2:in `<main>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:11:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend.rb:9:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend/transport_methods.rb:4:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36: warning: loading in progress, circular require considered harmful - /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend.rb
# ~> 	from -:2:in `<main>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:11:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend.rb:10:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend/object_methods.rb:4:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36: warning: loading in progress, circular require considered harmful - /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend.rb
# ~> 	from -:2:in `<main>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:11:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend.rb:11:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend/configuration.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/http_backend/key_streamer.rb:42: warning: mismatched indentations at 'end' with 'module' at 4
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/excon_backend.rb:57: warning: assigned but unused variable - response
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36: warning: loading in progress, circular require considered harmful - /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb
# ~> 	from -:2:in `<main>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:14:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/protobuffs_backend.rb:1:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/beefcake_protobuffs_backend.rb:215: warning: assigned but unused variable - e
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36: warning: loading in progress, circular require considered harmful - /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb
# ~> 	from -:2:in `<main>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:15:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/beefcake_protobuffs_backend.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36: warning: loading in progress, circular require considered harmful - /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb
# ~> 	from -:2:in `<main>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak.rb:3:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:55:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:17:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/stamp.rb:1:in `<top (required)>'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> 	from /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:210: warning: method redefined; discarding old client_id
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:290: warning: method redefined; discarding old http_backend=
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client.rb:383: warning: method redefined; discarding old protobuffs_backend=
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/map_reduce/phase.rb:42: warning: method redefined; discarding old type=
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/map_reduce/phase.rb:47: warning: method redefined; discarding old function=
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/map_reduce/results.rb:25: warning: assigned but unused variable - num
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/1.9.1/forwardable.rb:199: warning: method redefined; discarding old close
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/1.9.1/forwardable.rb:199: warning: previous definition of close was here
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/1.9.1/forwardable.rb:199: warning: method redefined; discarding old readline
# ~> /Users/rickwinfrey/.rvm/rubies/ruby-1.9.3-p0/lib/ruby/1.9.1/forwardable.rb:199: warning: previous definition of readline was here
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/excon_backend.rb:37: warning: method redefined; discarding old sockets
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/excon-0.16.10/lib/excon/connection.rb:370: warning: previous definition of sockets was here
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/util/escape.rb:55:in `escape': warning: URI.escape is obsolete
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/excon_backend.rb:51: warning: method redefined; discarding old make_request
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/excon_backend.rb:51: warning: previous definition of make_request was here
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/excon_backend.rb:66: warning: method redefined; discarding old configure_ssl
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/client/excon_backend.rb:66: warning: previous definition of configure_ssl was here
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:56: warning: instance variable @bucket not initialized
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:56: warning: instance variable @bucket not initialized
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:56: warning: instance variable @bucket not initialized
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:56: warning: instance variable @bucket not initialized
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:56: warning: instance variable @bucket not initialized
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:56: warning: instance variable @bucket not initialized
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:56: warning: instance variable @bucket not initialized
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:56: warning: instance variable @bucket not initialized
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/link.rb:56: warning: instance variable @bucket not initialized
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/util/escape.rb:55:in `escape': warning: URI.escape is obsolete
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/rcontent.rb:125: warning: instance variable @data not initialized
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/rcontent.rb:63: warning: instance variable @raw_data not initialized
# ~> /Users/rickwinfrey/.rvm/gems/ruby-1.9.3-p0/gems/riak-client-1.1.0/lib/riak/rcontent.rb:68: warning: instance variable @data not initialized
# ~> !XMP1357768579_93770_715036![1] => Riak::RObject #<Riak::RObject {games,first_game} [#<Riak::RContent [application/json]:nil>]>
# ~> client
# ~> _xmp_1357768579_93770_586988
# ~> first_game
