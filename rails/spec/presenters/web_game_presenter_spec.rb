require 'web_game_presenter'
require 'ttt/three_by_three'
require 'ttt/four_by_four'
require 'ttt/three_by_three_by_three'

describe WebGamePresenter do
  def show_board(presenter)
    string = presenter.show_board.scan(/<td|<tr|>[xo0-9]+</).join
    string.delete! "><"
    string
  end

  def presenter_for(klass, updates={})
    board = klass.new
    updates.each { |index, marker| board.update index, marker }
    described_class.for board: board
  end

  it 'blows up if given a board it does not know' do
    expect { described_class.for 'not a board' }.to raise_error
  end
end
