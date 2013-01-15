Given /^I am not yet playing$/ do
end

When /^I start a new console game$/ do
  board   = TTT::Board.new
  input   = StringIO.new("h\nc\nx\n")
  view    = TTT::View.new(outstream: output, instream: input)
  game    = TTT::Game.new(board: board, view: view)
  game.start
end

Then /^I should see "(.*?)"$/ do |message|
  output.messages.should include(message)
end

Then /^I move until it's a draw or someone wins$/ do
  board   = TTT::Board.new
  input   = StringIO.new
  view    = TTT::View.new(outstream: output, instream: input)
  game    = TTT::Game.new(board: board, view: view)
  game.player1 = TTT::Human.new
  game.player2 = TTT::Human.new
  game.player1.side = "x"
  game.player2.side = "o"
  game.current_player = game.player2
  game.board[] = ["x", "o", "x", "o", "x", "o", "x", "o", "x"]
  game.eval_board_state
end

class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message.strip
  end
end

def output
  @output ||= Output.new
end
