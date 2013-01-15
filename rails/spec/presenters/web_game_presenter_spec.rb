require 'spec_helper'
require 'web_game_presenter'

describe WebGamePresenter do
  def show_board(presenter)
    string = presenter.show_board.scan(/<td|<tr|>[xo]+</).join
    string.delete! "><"
    string
  end

  def presenter_for(options)
    board = options[:klass].new
    options[:updates].each { |index, marker| board.update index, marker }
    described_class.for(board: board, id: 1)
  end

  it 'renders a three_by_three board' do
    presenter = presenter_for klass: TTT::ThreeByThree, updates: { 0 => 'x', 1 => 'o' }
    show_board(presenter).should == "tr" "tdx" "tdo" "td" \
                                    "tr" "td" "td" "td" \
                                    "tr" "td" "td" "td"
  end

  it 'renders a four_by_four board' do
    presenter = presenter_for klass: TTT::FourByFour, updates: { 0 => 'x', 1 => 'o' }
    show_board(presenter).should == "tr" "tdx" "tdo" "td" "td" \
                                    "tr" "td" "td" "td" "td" \
                                    "tr" "td" "td" "td" "td" \
                                    "tr" "td" "td" "td" "td"

  end

  it 'renders a three_by_three_by_three board' do
    presenter = presenter_for klass: TTT::ThreeByThreeByThree, updates: { 0 => 'x', 1 => 'o' }
    show_board(presenter).should == "tr" "tdx" "tdo" "td" \
                                    "tr" "td" "td" "td" \
                                    "tr" "td" "td" "td" \
                                    \
                                    "tr" "td" "td" "td" \
                                    "tr" "td" "td" "td" \
                                    "tr" "td" "td" "td" \
                                    \
                                    "tr" "td" "td" "td" \
                                    "tr" "td" "td" "td" \
                                    "tr" "td" "td" "td" \
  end
end
