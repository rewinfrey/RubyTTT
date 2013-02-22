board_partial do
  game_board_row do
    @c.times do |c|
      squares do
        @n.times do |n|
          square :id => "square#{n + (c*9)}", :players => "board", :styles => "square#{n}" do
            square_text :id => "square_text_#{n + (c*9)}", :text => ""
          end
        end
      end
    end
  end
  __install "partials/menu_button_partial.rb"
end
