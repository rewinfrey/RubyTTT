require 'ttt/board'
module TTT
  class FourByFour < Board
    attr_accessor :x_arr, :diag_arr, :block_arr
    def initialize
      self.board   = Array.new(16, " ")
      self.x_arr   = [[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15]]
      self.diag_arr = [[0, 5, 10, 15], [3, 6, 9, 12]]
      self.block_arr = [[0,1,4,5], [1,2,5,6], [2,3,6,7], [4,5,8,9], [5,6,9,10], [6,7,10,11], [8,9,12,13], [9,10,13,14], [10,11,14,15]]
    end

    def winner?
      horizontal_winner? || vertical_winner? || diag_winner? || block_winner?
    end

    def horizontal_winner?
      x_arr.each do |x_win|
        return true if board[x_win[0]] != " " &&
                        board[x_win[0]] == board[x_win[1]] &&
                        board[x_win[1]] == board[x_win[2]] &&
                        board[x_win[2]] == board[x_win[3]]
      end
      false
    end

    def vertical_winner?
      x_arr.transpose.each do |y_win|
        return true if board[y_win[0]] != " " &&
                        board[y_win[0]] == board[y_win[1]] &&
                        board[y_win[1]] == board[y_win[2]] &&
                        board[y_win[2]] == board[y_win[3]]
      end
      false
    end

    def diag_winner?
      diag_arr.each do |diag_win|
         return true if board[diag_win[0]] != " " &&
                        board[diag_win[0]] == board[diag_win[1]] &&
                        board[diag_win[1]] == board[diag_win[2]] &&
                        board[diag_win[2]] == board[diag_win[3]]

      end
      false
    end

    def block_winner?
      block_arr.each do |block_win|
         return true if board[block_win[0]] != " " &&
                        board[block_win[0]] == board[block_win[1]] &&
                        board[block_win[1]] == board[block_win[2]] &&
                        board[block_win[2]] == board[block_win[3]]

      end
      false
    end

    def board_type
      "four_by_four"
    end
  end
end
