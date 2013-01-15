require 'spec_helper'
require 'ttt/game_builder'

describe "new game scene" do
  uses_limelight :scene => "new_game", :hidden => true, :stage => 'default'

  %w(player1 player2).each do |player_num|
    it "has a #{player_num}" do
      player = scene.find("#{player_num}")
      player.should_not be_nil
      player.drop_down.value.should == TTT::GameBuilder.new.players.first
    end
  end

  it "has a setup_button" do
    scene.find("setup_button").should_not be_nil
    scene.find("setup_button").text.should == "Start Game"
  end

  it "has a board list" do
    scene.find("board").drop_down.value.should == TTT::GameBuilder.new.boards.first
  end

  [1,2].each do |num|
    it "finds the dropdown values for player#{num}" do
      scene.find("player#{num}").text.should == "Human"
    end
  end

  context "when start game button is pressed" do
    it "creates a new game" do
      scene.find("player1").drop_down.value = "AI Medium"
      scene.find("player2").drop_down.value = "AI Medium"
      scene.find("board").drop_down.value = "3x3"
      mouse.push scene.find("setup_button")
      game_scene = production.open_scene("three_by_three")
      production.game.should_not be_nil
    end
  end
end
