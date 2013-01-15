module CLI
  class PlayAgain
    attr_accessor :view

    def initialize(options)
      self.view = options.fetch(:view)
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
        view.generic_error_msg
        play_again?
      end
    end

    def input
      @view.input
    end

    def valid_reply?(response)
      response =~ (/(y|n)/i)
    end

    def play_again_msg
      view.play_again_msg
    end
  end
end
