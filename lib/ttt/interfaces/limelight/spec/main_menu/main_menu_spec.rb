require 'spec_helper'
require 'ttt/setup'
require 'ttt/context'

describe "main menu scene" do

  uses_limelight :scene => "main_menu", :hidden => true

  it "has a 'new game' button" do
    button = scene.find("new_game")
    button.text.should == "New Game"
  end

  it "has a 'load game' button" do
    button = scene.find("load_game")
    button.text.should == "Load Game"
  end

  it "has a 'exit' button" do
    button = scene.find("exit")
    button.text.should == "Exit"
  end

  context "user clicks `Play Game`" do
    xit "loads the 'new_game' scene" do
      new_game_button = scene.find("new_game")
      mouse.push new_game_button
      current_scene.name.should == "new_game"
    end
  end

  context "user clicks `Load Game`" do
    xit "loads the 'load_game' scene" do
      mouse.push scene.find("load_game")
      current_scene.name.should == "LoadGame"
    end
   end
end
