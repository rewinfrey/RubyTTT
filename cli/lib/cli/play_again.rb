module CLI
  class PlayAgain
    attr_accessor :presenter

    def initialize(presenter)
      self.presenter = presenter
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
        presenter.error
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
