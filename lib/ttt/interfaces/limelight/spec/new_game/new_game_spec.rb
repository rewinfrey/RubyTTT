require 'spec_helper'
require 'ttt/setup'
require 'ttt/context'

describe "new game scene" do

  uses_limelight :scene => "new_game", :hidden => true

  %w(player1 player2).each do |player_num|
    it "has a #{player_num}" do
      player = scene.find("#{player_num}")
      player.should_not be_nil
      player.drop_down.value.should == TTT::Setup.new.players.first
    end
  end

  it "has a setup_button" do
    scene.find("setup_button").should_not be_nil
    scene.find("setup_button").text.should == "Start Game"
  end

  it "has a board list" do
    scene.find("board").drop_down.value.should == TTT::Setup.new.boards.first
  end

  [1,2].each do |num|
    it "finds the dropdown values for player#{num}" do
      scene.find("player#{num}").text.should == "Human"
    end
  end

  it "adds a context singleton to production" do
    production.context.class.should == TTT::Context
  end

  context "when start game button is pressed" do
    it "creates a new game" do
      scene.find("player1").drop_down.value = "AI Medium"
      scene.find("player2").drop_down.value = "AI Medium"
      scene.find("board").drop_down.value = "3x3"
      mouse.push scene.find("setup_button")
      production.game_id.should_not == nil
    end
  end
end
