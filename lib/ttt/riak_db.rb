require 'riak'
module TTT
  class RiakDB
    Riak.disable_list_keys_warnings = true
    attr_accessor :client, :bucket, :cur_id
    def initialize(options)
      port            = options.fetch(:port, 8098)
      http_backend    = options.fetch(:http_backend, :Excon)
      self.bucket     = options.fetch(:bucket)
      self.client     = Riak::Client.new(:http_port => port, :http_backend => http_backend)
      self.cur_id     = client[bucket].keys.length.to_s
    end

    def add_game(game)
      self.cur_id = inc_cur_id
      new_game              = client[bucket].get_or_new(cur_id)
      new_game.content_type = "text/yaml"
      new_game.data         = { :game => game, :id => cur_id }
      new_game.store
      cur_id
    end

    def game_list
      client[bucket].keys.map(&:to_i).sort.map(&:to_s)
    end

    def get_game(id)
      begin
        game = client[bucket].get(id.to_s)
      rescue Riak::HTTPFailedRequest
        nil
      else
        game.data[:game]
      end
    end

    def save_game(id, game)
      riak_game      = client[bucket].get(id)
      riak_game.data = { :game => game, :id => id }
      riak_game.store
    end

    def delete_game(id)
      riak_game      = client[bucket].get(id)
      riak_game.delete
    end

    private
    def inc_cur_id
      (client[bucket].keys.length + 1).to_s
    end
  end
end
