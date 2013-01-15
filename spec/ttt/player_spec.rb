require 'spec_helper'

module TTT
  describe Player do

     describe "#initialize" do
       it "should initialize a blank new player" do
         player = Player.new(side: "x")
         player.side.should == "x"
       end
     end
  end
end
