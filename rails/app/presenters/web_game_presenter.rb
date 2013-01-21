module WebGamePresenter
  def self.for(options)
    klass = case options.fetch :board
            when TTT::ThreeByThree        then ThreeByThree
            when TTT::FourByFour          then FourByFour
            when TTT::ThreeByThreeByThree then ThreeByThreeByThree
            else
              raise ArgumentError, "Unknown board: #{board.inspect}"
            end
    klass.new board: options[:board], id: options[:id], core: options[:core]
  end

  class Base

    def initialize(options)
      self.board = options.fetch :board
      self.id    = options.fetch :id
      self.core  = options.fetch(:core, false)
    end

    def board
      board.board[]
    end

    def side_class(square)
      return 'x_taken_square' if square == "x"
      'o_taken_square'
    end

    def generate_form(index)
      if core
        %Q(<form id="#{index}" class="core_untaken_square" accept-charset="UTF-8" action="/game/#{id}/mark_move" method="post"><input type="hidden" name="move" value="#{index}"></form>)
      else
        %Q(<form id="#{index}" class="untaken_square" accept-charset="UTF-8" action="/web_games/#{id}/mark_move" method="post"><input type="hidden" name="move" value="#{index}"></form>)
      end
    end

    def determine_untaken_square_class
      core ? "core_untaken" : "untaken"
    end

    attr_accessor :board, :id, :core
  end

  class ThreeByThree < Base
    def show_board
      html_string = "<table class='three_by_three'><tr>"
      board[].each_with_index do |square, index|
        html_string += "</tr><tr>" if index % 3 == 0 && index != 0
        if square == " "
          html_string += %Q(#{generate_form(index) unless board.finished?}<td value="#{index}" class="square #{determine_untaken_square_class} #{square_class(index)}"></td>)
        else
          html_string += %Q(<td id="#{index}" name="move" class="square #{side_class(square)} #{square_class(index)}">#{square}</td>)
        end
      end
      html_string += "</tr></table>"
    end

    def square_class(index)
      html_class = case index
                   when 0 then 'top_left'
                   when 1 then 'top_middle'
                   when 2 then 'top_right'
                   when 3 then 'middle_left'
                   when 4 then 'middle'
                   when 5 then 'middle_right'
                   when 6 then 'bottom_left'
                   when 7 then 'bottom_middle'
                   when 8 then 'bottom_right'
                   end
    end
  end

  class FourByFour < Base
    def show_board
      html_string = "<table class='four_by_four'><tr>"
      board[].each_with_index do |square, index|
        html_string += "</tr><tr>" if index % 4 == 0 && index != 0
        if square == " "
          html_string += %Q(#{generate_form(index) unless board.finished?}<td value="#{index}" class="square #{determine_untaken_square_class} #{square_class(index)}"></td>)
        else
          html_string += %Q(<td id="#{index}" class="square #{side_class(square)} #{square_class(index)}">#{square}</td>)
        end
      end
      html_string += "</tr></table>"
    end

    def square_class(index)
      html_class = case index
                   when 0                  then 'top_left'
                   when 1                  then 'top_middle'
                   when 2                  then 'top_middle'
                   when 3                  then 'top_right'
                   when 4                  then 'middle_left'
                   when 5                  then 'middle'
                   when 6                  then 'middle'
                   when 7                  then 'middle_right'
                   when 8                  then 'middle_left'
                   when 9                  then 'middle'
                   when 10                 then 'middle'
                   when 11                 then 'middle_right'
                   when 12                 then 'bottom_left'
                   when 13                 then 'bottom_middle'
                   when 14                 then 'bottom_middle'
                   when 15                 then 'bottom_right'
                   end
    end
  end

  class ThreeByThreeByThree < Base
    def show_board
      html_string = ""
      board[].each_slice(9).with_index do |board_level, board_level_index|
        html_string += "<table class='three_by_three_by_three'><tr>"
        board_level.each_with_index do |square, index|
          html_string += "</tr><tr>" if index % 3 == 0 && index != 0
          if square == " "
            html_string += %Q(#{generate_form(index + (board_level_index * 9)) unless board.finished?}<td value="#{index + (board_level_index * 9)}" class="square #{determine_untaken_square_class} #{square_class(index)}"></td>)
          else
            html_string += %Q(<td id="#{index}" class="square #{side_class(square)} #{square_class(index)}">#{square}</td>)
          end
        end
        html_string += "</tr></table>"
      end
      html_string
    end

    def square_class(index)
      html_class = case index
                   when 0               then 'top_left'
                   when 1               then 'top_middle'
                   when 2               then 'top_right'
                   when 3               then 'middle_left'
                   when 4               then 'middle'
                   when 5               then 'middle_right'
                   when 6               then 'bottom_left'
                   when 7               then 'bottom_middle'
                   when 8               then 'bottom_right'
                   when 9               then 'top_left'
                   when 10              then 'top_middle'
                   when 11              then 'top_right'
                   when 12              then 'middle_left'
                   when 13              then 'middle'
                   when 14              then 'middle_right'
                   when 15              then 'bottom_left'
                   when 16              then 'bottom_middle'
                   when 17              then 'bottom_right'
                   when 18              then 'top_left'
                   when 19              then 'top_middle'
                   when 20              then 'top_right'
                   when 21              then 'middle_left'
                   when 22              then 'middle'
                   when 23              then 'middle_right'
                   when 24              then 'bottom_left'
                   when 25              then 'bottom_middle'
                   when 26              then 'bottom_right'
                  end
    end
  end
end
