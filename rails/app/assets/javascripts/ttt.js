$(document).ready( function(){
  $('td.untaken_square').click(mark_move);
  $('.current_player').bind(next_move);
  window.setTimeout( function() { next_move()}, 1500);
});

function mark_move() {
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
