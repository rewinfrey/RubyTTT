module CLI
  class CLIO
    attr_accessor :outstream, :instream
    def initialize(input, output)
      self.outstream    = output
      self.instream     = input
    end

    def output(message)
      outstream.puts message
    end

    def input
      instream.gets
    end
  end
end
