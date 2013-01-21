$(document).ready( function(){
  $('td.untaken').click(mark_move);
  $('td.core_untaken').click(core_mark_move);
  $('.current_player').bind(next_move);
  $('.core_current_player').bind(core_next_move);
  $('#button_right').click(next_history_move);
  $('#button_left').click(previous_history_move);
  window.setTimeout( function() { next_move()}, 1500);
  window.setTimeout( function() { core_next_move()}, 1500);
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
    window.location = "/web_games/"+id+"/computer_move";
  }
}

function core_next_move() {
  val = $('#core_current_player').html();
  if (val.trim() == "true") {
    id = $('#core_current_player').attr('game_id');
    window.location = "/game/"+id+"/computer_move";
  }
}

function next_history_move() {
  val = $('#move_index').attr("data");
  val = parseInt(val) + 1;
  id  = $('#core_current_player').attr('game_id');
  window.location = "/game/"+id+"/next_history_move?move_index="+val;
}

function previous_history_move() {
  val = $('#move_index').attr("data");
  val = parseInt(val) - 1;
  id  = $('#core_current_player').attr('game_id');
  window.location = "/game/"+id+"/next_history_move?move_index="+val;
}
