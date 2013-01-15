module CLI
  class View
    attr_accessor :outstream, :instream
    def initialize(options)
      self.outstream    = options.fetch(:outstream, $stdout)
      self.instream     = options.fetch(:instream, $stdin)
    end

    def clear
      puts "\e[2J"
      puts "\e[0;0H"
    end

    def output(message)
      outstream.puts "\n#{message}"
    end

    def player_prompt(player)
      outstream.puts "\n#{player.prompt}"
    end

    def human_prompt
      outstream.puts "\nEnter move:"
    end

    def computer_prompt
      outstream.puts "\nComputer thinking..."
    end

    def player_type_prompt(num, options)
      output "\nPlease select an option for Player #{num}:\n"
      display_options_with_index(options)
   end

    def command_list
      output "\nPlease select an option from the following list:\n"
      output "1. Play TTT!\n2. Load game\n3. Quit"
    end

    def db_list
      output "\nPlease select an game from the list:\n"
    end

    def game_list(games)
      games.each { |game| output game }
    end

    def no_games_saved
      output "No games saved yet."
    end

    def display_options_with_index(options)
      options.each_with_index do |option, index|
        print "\n#{index + 1}: #{option}"
      end
      print "\n"
    end

    def board_selection_prompt(options)
      clear
      outstream.puts "\nPlease select which board you'd like to play:\n"
      display_options_with_index(options)
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
      outstream.puts "\nPlay again (y or n)?"
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

    def input
      instream.gets
    end

    def generic_error_msg
      outstream.puts "\nI'm sorry, I didn't understand. Please try again."
    end

    def output_move_error
      outstream.puts "\nCannot move there! >.< Please try another square."
    end

    def winner_prompt(winner)
      outstream.puts "\n#{winner} is the winner!"
    end

    def draw_prompt
      outstream.puts "\nIt's a draw!"
    end

    def output_three_by_three(board)
      outstream.puts("\n  #{board[0]}  |  #{board[1]}  |  #{board[2]}  \n-----------------\n  #{board[3]}  |  #{board[4]}  |  #{board[5]}  \n-----------------\n  #{board[6]}  |  #{board[7]}  |  #{board[8]}  ")
    end

    def output_four_by_four(board)
      outstream.puts("\n  #{board[0]}  |  #{board[1]}  |  #{board[2]}  |  #{board[3]}  \n-----------------------\n  #{board[4]}  |  #{board[5]}  |  #{board[6]}  |  #{board[7]}  \n-----------------------\n  #{board[8]}  |  #{board[9]}  |  #{board[10]}  |  #{board[11]}  \n-----------------------\n  #{board[12]}  |  #{board[13]}  |  #{board[14]}  |  #{board[15]}   ")
    end

    def output_3d(board)
      outstream.puts("\n  #{board[0]}  |  #{board[1]}  |  #{board[2]}       #{board[9]}  |  #{board[10]}  |  #{board[11]}       #{board[18]}  |  #{board[19]}  |  #{board[20]}   \n-----------------   -----------------   -----------------\n  #{board[3]}  |  #{board[4]}  |  #{board[5]}       #{board[12]}  |  #{board[13]}  |  #{board[14]}       #{board[21]}  |  #{board[22]}  |  #{board[23]}   \n-----------------   -----------------   -----------------\n  #{board[6]}  |  #{board[7]}  |  #{board[8]}       #{board[15]}  |  #{board[16]}  |  #{board[17]}       #{board[24]}  |  #{board[25]}  |  #{board[26]}  ")
    end

    def three_d_prompt
      outstream.puts("\n  0  |  1  |  2       9  |  10 |  11      18 |  19 |  20  \n-----------------   -----------------   -----------------\n  3  |  4  |  5       12 |  13 |  14      21 |  22 |  23 \n-----------------   -----------------   -----------------\n  6  |  7  |  8       15 |  16 |  17      24 |  25 |  26 ")
    end

    def regular_move_prompt
      outstream.puts("\n  0  |  1  |  2  \n-----------------\n  3  |  4  |  5  \n-----------------\n  6  |  7  |  8  ")
    end

    def four_by_four_move_prompt
      outstream.puts("\n  0  |  1  |  2  |  3  \n-----------------------\n  4  |  5  |  6  |  7  \n-----------------------\n  8  |  9  | 10  | 11  \n-----------------------\n 12  | 13  | 14  | 15   ")
    end

    def welcome_prompt
      clear
      outstream.puts("\nWelcome to TTT!")
    end
  end
end
