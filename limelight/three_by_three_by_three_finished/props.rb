move_button_row do
  left_button :players => "button", :id => "left_button", :text => "Back"
  right_button :players => "button", :id => "right_button", :text => "Next"
end
__install "partials/title_history_partial.rb", :c => 3, :n => 9, :text => "3x3x3"
