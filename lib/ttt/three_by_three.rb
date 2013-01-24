require 'ttt/board'

module TTT
  class ThreeByThree < Board
    attr_accessor :win_arr, :win_block
    def initialize
      self.board   = Array.new(9, " ")
      self.win_arr = [[0,1,2], [0,4,8], [0,3,6], [1,4,7], [2,5,8], [2,4,6], [3,4,5], [6,7,8]]
      self.win_block = [[0,1,3,4], [1,2,4,5], [3,4,6,7], [4,5,7,8]]
    end

    def winner?
      win_arr.each do |win_combo|
        return true if board[win_combo[0]] == board[win_combo[1]] &&
                       board[win_combo[1]] == board[win_combo[2]] &&
                       board[win_combo[0]] != " "
      end
      block_winner?
    end

    def block_winner?
      win_block.each do |win_combo|
        return true if board[win_combo[0]] == board[win_combo[1]] &&
                       board[win_combo[1]] == board[win_combo[2]] &&
                       board[win_combo[2]] == board[win_combo[3]] &&
                       board[win_combo[0]] != " "
      end
      false
    end

    def board_type
      "three_by_three"
    end
  end
end
