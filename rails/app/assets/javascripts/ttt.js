$(document).ready( function(){
  $('td.human').click(mark_move);
  $('.current_player').bind(next_move);
  $('#button_right').click(next_history_move);
  $('#button_left').click(prev_history_move);
  window.setTimeout( function() { next_move()}, 1500);
});

function mark_move() {
  id = $(this).attr("value");
  $("#"+id+"").submit();
}

function core_mark_move() {
  id = $(this).attr("value");
  $("#"+id+"").submit();
}

function next_move() {
  val = $('#current_player').html();
  if (val.trim() == "true") {
    id = $('#current_player').attr('game_id');
    window.location = "/ttt_games/"+id+"/next_move";
  }
}

function prev_history_move() {
  get_board_history(-1);
}

function next_history_move() {
  get_board_history(1);
}

function get_board_history(diff) {
  window.location = "/ttt_games/"+find_id()+"/move_history?index_diff="+diff;
}

function find_id() {
  return $('#current_player').attr('game_id');
}
