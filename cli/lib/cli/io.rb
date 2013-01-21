module CLI
  class IO
    attr_accessor :outstream, :instream
    def initialize(options)
      self.outstream    = options.fetch(:outstream, $stdout)
      self.instream     = options.fetch(:instream, $stdin)
    end

    def output(message)
      outstream.puts "#{message}"
    end

    def input
      instream.gets
    end
  end
end
