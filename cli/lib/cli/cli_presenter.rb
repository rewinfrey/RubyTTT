module CLI
  class CLIPresenter
    attr_accessor :io
    def initialize(input, output)
      self.io = IO.new(instream: input, outstream: output)
    end

    def output(args)
      io.output args
    end

    def input
      io.input
    end

    def welcome_prompt
      output "Welcome to TTT!"
    end

    def command_list
      output "\nPlease select an option from the following list:\n"
      output "1. Play TTT!"
      output "2. Load game"
      output "3. Quit"
    end

    def menu
      welcome_prompt
      command_list
    end

    def game_list(list)
      sort_list(list).each do |game_key|
        output game_key
      end
    end

    def sort_list(list)
      list.map(&:to_i).sort.map(&:to_s)
    end

    def no_games
      output "No games were found."
      menu
    end

    def player_type_prompt(num, players)
      output "\nPlease select an option for Player #{num}:\n"
      display_options_with_index(players)
      input
    end

    def select_game_prompt
      output "\nPlease select an game from the list:\n"
    end

    def player_prompt(player)
      output "\n#{player.prompt}"
    end

    def board_selection_prompt(boards)
      clear
      output "\nPlease select which board you'd like to play:\n"
      display_options_with_index(boards)
    end

    def display_options_with_index(options)
      options.each_with_index do |option, index|
        output "#{index + 1}: #{option}"
      end
    end

    def clear
      output "\e[2J"
      output "\e[0;0H"
    end

    def ai_difficulty_prompt(ai_options)
      clear
      output "\nChoose a difficulty level for the computer:"
      ai_options.inject(1) do |index, difficulty|
        output "#{index}. #{difficulty.to_s.gsub(/TTT::AI/, '')}"
        index += 1
      end
    end

    def play_again_msg
      output "\nPlay again (y or n)?"
    end

    def output_board(board)
      output_help(board)
      output "\n"
      case board.length
      when 9
        output_three_by_three(board)
      when 16
        output_four_by_four(board)
      when 27
        output_3d(board)
      end
    end

    def output_help(board)
      clear
      output "\nMove options:"
      case board.length
      when 9
       regular_move_prompt
      when 16
       four_by_four_move_prompt
      when 27
        three_d_prompt
      end
      output "\n"
    end

    def generic_error_msg
      output "\nI'm sorry, I didn't understand. Please try again."
    end

    def output_move_error
      output "\nCannot move there! >.< Please try another square."
    end

    def winner_prompt(winner)
      output "\n#{winner} is the winner!"
    end

    def draw_prompt
      output "\nIt's a draw!"
    end

    def output_three_by_three(board)
      output("\n  #{board[0]}  |  #{board[1]}  |  #{board[2]}  \n-----------------\n  #{board[3]}  |  #{board[4]}  |  #{board[5]}  \n-----------------\n  #{board[6]}  |  #{board[7]}  |  #{board[8]}  ")
    end

    def output_four_by_four(board)
      output("\n  #{board[0]}  |  #{board[1]}  |  #{board[2]}  |  #{board[3]}  \n-----------------------\n  #{board[4]}  |  #{board[5]}  |  #{board[6]}  |  #{board[7]}  \n-----------------------\n  #{board[8]}  |  #{board[9]}  |  #{board[10]}  |  #{board[11]}  \n-----------------------\n  #{board[12]}  |  #{board[13]}  |  #{board[14]}  |  #{board[15]}   ")
    end

    def output_3d(board)
      output("\n  #{board[0]}  |  #{board[1]}  |  #{board[2]}       #{board[9]}  |  #{board[10]}  |  #{board[11]}       #{board[18]}  |  #{board[19]}  |  #{board[20]}   \n-----------------   -----------------   -----------------\n  #{board[3]}  |  #{board[4]}  |  #{board[5]}       #{board[12]}  |  #{board[13]}  |  #{board[14]}       #{board[21]}  |  #{board[22]}  |  #{board[23]}   \n-----------------   -----------------   -----------------\n  #{board[6]}  |  #{board[7]}  |  #{board[8]}       #{board[15]}  |  #{board[16]}  |  #{board[17]}       #{board[24]}  |  #{board[25]}  |  #{board[26]}  ")
    end

    def three_d_prompt
      output("\n  0  |  1  |  2       9  |  10 |  11      18 |  19 |  20  \n-----------------   -----------------   -----------------\n  3  |  4  |  5       12 |  13 |  14      21 |  22 |  23 \n-----------------   -----------------   -----------------\n  6  |  7  |  8       15 |  16 |  17      24 |  25 |  26 ")
    end

    def regular_move_prompt
      output("\n  0  |  1  |  2  \n-----------------\n  3  |  4  |  5  \n-----------------\n  6  |  7  |  8  ")
    end

    def four_by_four_move_prompt
      output("\n  0  |  1  |  2  |  3  \n-----------------------\n  4  |  5  |  6  |  7  \n-----------------------\n  8  |  9  | 10  | 11  \n-----------------------\n 12  | 13  | 14  | 15   ")
    end

    def welcome_prompt
      clear
      output("\nWelcome to TTT!")
    end






  end
end
