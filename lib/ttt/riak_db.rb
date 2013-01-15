require 'riak'

module TTT
  class RiakDB
    Riak.disable_list_keys_warnings = true
    attr_accessor :client, :id
    def initialize(options)
      port = options.fetch(:port, 8098)
      http_backend = options.fetch(:http_backend, :Excon)
      self.client = Riak::Client.new(:http_port => port, :http_backend => http_backend)
    end

    def add_game(options)
      self.id               = client["#{options.fetch(:list_name)}"].keys.length + 1
      new_game              = client["#{options.fetch(:list_name)}"].get_or_new(id.to_s)
      new_game.content_type = "text/yaml"
      new_game.data         = { :game => options.fetch(:game), :id => id }
      new_game.store
    end

    def game_list(options)
      client["#{options.fetch(:list_name)}"].keys.map(&:to_i).sort.map(&:to_s)
    end

    def load_game(options)
      client["#{options.fetch(:list_name)}"].get_or_new(options.fetch(:id)).data[:game]
    end

    def save_game(options)
      game = client["#{options.fetch(:list_name)}"].get(options.fetch(:id))
      game.data = { :game => options.fetch(:game), :id => options.fetch(:id) }
      game.store
    end
  end
end
