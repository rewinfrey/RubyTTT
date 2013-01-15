module TTT
  describe Human do
    let(:human) { Human.new(side: "x") }
    let(:game)  { Game.new(view: view, board: board) }

    describe "#no_gui?" do
      it "returns false" do
        human.no_gui?.should == false
      end
    end

    describe "#prompt" do
      it "returns 'Player thinking'" do
        human.prompt.should == "Enter move:"
      end
    end
  end
end
