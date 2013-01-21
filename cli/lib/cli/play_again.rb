module CLI
  class PlayAgain
    attr_accessor :presenter

    def initialize(options)
      self.presenter = options.fetch(:presenter)
    end

    def play_again?
      play_again_msg
      process_reply input
    end

    def process_reply reply
      if valid_reply?(reply)
        return false if reply.chomp == "n"
        true
      else
        presenter.generic_error_msg
        play_again?
      end
    end

    def input
      presenter.input
    end

    def valid_reply?(response)
      response =~ (/(y|n)/i)
    end

    def play_again_msg
      presenter.play_again_msg
    end
  end
end
