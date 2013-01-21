require 'ttt/ai'
require 'ttt/ai_easy'
require 'ttt/ai_medium'
require 'ttt/ai_hard'
require 'ttt/human'
require 'ttt/board'
require 'ttt/three_by_three'
require 'ttt/four_by_four'
require 'ttt/three_by_three_by_three'
require 'ttt/game_history'
require 'ttt/riak_db'
require 'ttt/game_interactor'

module TTT
  class ConfigOptions
    BOARDS                 = [TTT::ThreeByThree, TTT::FourByFour, TTT::ThreeByThreeByThree]
    HUMAN_READABLE_BOARDS  = %w(3x3 4x4 3x3x3)
    PLAYERS                = [TTT::Human, TTT::AIEasy, TTT::AIMedium, TTT::AIHard]
    HUMAN_READABLE_PLAYERS = ["Human", "AI Easy", "AI Medium", "AI Hard"]
    DB                     = TTT::RiakDB
    PORT                   = 8091 # 8098 is default
    HTTP_BACKEND           = :Excon
    BUCKET                 = "ttt_games"
    HISTORY                = TTT::GameHistory
    INTERACTOR             = TTT::GameInteractor
  end
end
