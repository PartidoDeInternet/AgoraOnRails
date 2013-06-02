require File.dirname(__FILE__) + "/../spec_helper"

describe Proposal do

  describe "hot" do
    it "only shows open proposals" do
      proposal = create_proposal(title: "Free WI-FI", closed_at: 1.day.ago)
      proposal = create_proposal(title: "Public Health")
      
      hot = Proposal.hot
      hot.count.should == 1
      hot.first.title.should == "Public Health"
    end

    it "only show 5 proposals" do
      6.times { create_proposal }  
      Proposal.hot.count.should == 5
    end

    it "orders by votes" do
      proposal = create_proposal(title: "Free WI-FI",       votes_count: 1)
      proposal = create_proposal(title: "Public Education", votes_count: 3)
      proposal = create_proposal(title: "Public Health",    votes_count: 2)
      
      hot = Proposal.hot
      hot.count.should == 3
      hot.map(&:title).should == ["Public Education", "Public Health", "Free WI-FI"]
    end

    it "orders by visits" do
      proposal = create_proposal(title: "Free WI-FI",       visits: 100)
      proposal = create_proposal(title: "Public Education", visits: 300)
      proposal = create_proposal(title: "Public Health",    visits: 200)
      
      hot = Proposal.hot
      hot.count.should == 3
      hot.map(&:title).should == ["Public Education", "Public Health", "Free WI-FI"]
    end
  end
end