module TTT
  class Board
    attr_accessor :board

    def []
      board
    end

    def []=(array)
      self.board = array
    end

    def update cell, side
      self.board[cell.to_i] = side
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
      (!board.include? " ") && !winner?
    end
  end
end
