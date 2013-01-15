setup_list {
  text_color :white
  font_size 20
  width "50%"
  horizontal_alignment :right
  vertical_alignment :top
  right_margin 20
  bottom_margin 20
}

type_list {
  text_color :black
  font_size 20
  width "25%"
  horizontal_alignment :left
  left_margin 20
}

setup_button_row {
  width "100%"
  horizontal_alignment :center
}

player1 {
  extends :setup_list
}

player1_type {
  extends :type_list
}

player2 {
  extends :setup_list
}

player2_type {
  extends :type_list
}

boards {
  extends :setup_list
}

board {
  extends :type_list
}

row {
  height "10%"
  width "100%"
}

third {
  width "33%"
}

half {
  width "50%"
}

title {
  horizontal_alignment :center
  top_margin 100
  font_size 40
  text_color :white
  width "100%"
}
