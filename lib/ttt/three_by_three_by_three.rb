require 'ttt/board'
module TTT
  class ThreeByThreeByThree < Board
    attr_accessor :win_arr
    def initialize
      self.board   = Array.new(27, " ")

      self.win_arr = [[0,1,2], [0,4,8], [0,3,6], [1,4,7],
                      [2,5,8], [2,4,6], [3,4,5], [6,7,8],
                      [9,10,11], [12,13,14], [15,16,17],
                      [9,12,15], [10,13,16], [11,14,17],
                      [9,13,17], [11,13,15], [18,19,20],
                      [21,22,23], [24,25,26], [18,21,24],
                      [19,22,25], [20,23,26], [18,22,26],
                      [20,22,24], [0,9,18], [1,10,19], [2,11,20],
                      [3,12,21], [4,13,22], [5,14,23], [6,15,24],
                      [7,16,25], [8,17,26], [0,13,26], [2,13,24],
                      [2,14,26], [0,12,24], [1,13,25], [6,13,20],
                      [8,13,18], [3,13,23], [5,13,21], [6,16,26],
                      [7,13,19], [8,16,24], [0,10,20], [2,10,18],
                      [6,12,18], [8,14,20]]
    end

    def winner?
      win_arr.each do |win_combo|
        return true if board[win_combo[0]] == board[win_combo[1]] &&
                       board[win_combo[1]] == board[win_combo[2]] &&
                       board[win_combo[0]] != " "
      end
      false
    end

    def board_type
      "three_by_three_by_three"
    end
  end
end
