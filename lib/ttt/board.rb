module TTT
  class Board
    attr_accessor :board, :win_arr
    def initialize
      self.board   = Array.new(9, " ")
      self.win_arr = [[0,1,2], [0,4,8], [0,3,6], [1,4,7], [2,5,8], [2,4,6], [3,4,5], [6,7,8]]
    end

    def []
      board
    end

    def []=(array)
      self.board = array
    end

    def update cell, side
      self.board[cell] = side
    end

    def empty?
      !(board.include?("x") || board.include?("o"))
    end

    def full?
      !board.include?(" ")
    end

    def free?(cell)
      board[cell] == " "
    end

    def finished?
      draw_game? || winner?
    end

    def draw_game?
      !board.include? " "
    end

    def winner?
      win_arr.each do |win_combo|
        return true if board[win_combo[0]] == board[win_combo[1]] &&
                       board[win_combo[1]] == board[win_combo[2]] &&
                       board[win_combo[0]] != " "
      end
      false
    end
  end
end
