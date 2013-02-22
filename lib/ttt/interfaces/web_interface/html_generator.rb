module TTT
  class HtmlGenerator
    def initialize
    end

    def new_game
      html_string = html_open
      html_string += html_close
    end

    def show_game(game, game_id, game_history)
    end

    def game_list(games)
    end

    def hidden_field(game, game_id)
      html_string = ""
      html_string += %q[<div id="current_player" game_id="#{game_id}">]
      html_string += true if game.ai_move? && !game.board.finished?
      html_string += "</div>"
    end

    def main_body(flash_message, web_game_presenter)
      html_string = ""
      html_string += %q[<div style="width: 1020px; margin: 100px auto 20px auto;">]
      html_string += %q[<h4 class="notice">#{flash_message}</h4>] if flash_message
      html_string += web_game_presenter.show_board
      html_string += "</div>"
    end

    def move_history
      html_string = ""
      html_string += %q[<div id="buttons" style="width: 800px; margin: auto;">]
      html_string += %q[<div id="button_left" style="float: left; margin-left: 200px;">]
      html_string += %q[<img src="/images/button_left.png" class="pointer" /></div>]
      html_string += %q[<div id="button_right" style="float: right; margin-right: 200px;">]
      html_string += %q[<img src="/images/button_right.png" class="pointer" /></div></div>]
    end

    def move_index(web_game_history)
      html_string = ""
      html_string += %q[<div class="move_history" style="float: right; width: 170px; height: 800px; text-align: right;">]
      html_string += %q[<h4 style="text-align: center;">Move History</h4>]
      html_string += %q[<ul style="width: 215px;">]
      game_history.each_with_index do |move, index|
        move_list_class = index == 0 ? "move_list_first" : "move_list"
        html_string += %q[<li class="#{move_list_class}"><span style="margin-right: 10px;">#{index + 1})</span>]
        html_string += %q[<span style="margin-right: 10px;">#{move.side}</span> #{move.move}]
      end
      html_string += "</ul></div>"
    end

    def html_open
      html_string = ""
      html_string += %q[<!DOCTYPE html>]
      html_string += %q[<html><head><title>Java Server TTT</title>]
      html_string += %q[<link href="/images/favicon.ico" rel="shortcut icon" type="image/vnd.microsoft.icon" />]
      html_string += %q[<link href="/css/application.css" media="all" rel="stylesheet" type="text/css" />]
      html_string += %q[<link href="/css/tictactoe.css" media="all" rel="stylesheet" type="text/css" />]
      html_string += %q[<link href="/css/web_game.css" media="all" rel="stylesheet" type="text/css" />]
      html_string += %q[<script src="/js/jquery.js" type="text/javascript"></script>]
      html_string += %q[<script src="/js/ttt.js" type="text/javascript"></script>]
      html_string += %q[<script src="/js/application.js" type="text/javascript"></script></head>]
      html_string += %q[<body><div class="main_buttons"><div class="new_game_btn_wrapper">]
      html_string += %q[<a href="/new_game" class="button">New Game</a></div>]
      html_string += %q[<div class="all_games_btn_wrapper">]
      html_string += %q[<a href="/game_list" class="button">All Games</a></div>]
      html_string += %q[</div>]
    end

    def html_close
      "</body></html>"
    end
  end
end
