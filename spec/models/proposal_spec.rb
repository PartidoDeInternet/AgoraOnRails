require File.dirname(__FILE__) + "/../spec_helper"

describe Proposal do
  describe "#total_representatives" do
    it "calculates representative votes when all citizens vote the same" do
      proposal = create_proposal(:title => "free WI-FI", 
                                 :in_favor   => 20, 
                                 :against    => 0, 
                                 :abstention => 0)
      proposal.total_representatives_in_favor(5).should == 5
      proposal.total_representatives_against(5).should == 0
      proposal.total_representatives_abstention(5).should == 0
    end
    
    it "calculates when even percentage of citizen vote and even number of representative" do
      proposal = create_proposal(:title => "free WI-FI", 
                                 :in_favor   => 10, 
                                 :against    => 10, 
                                 :abstention => 10)
      proposal.total_representatives_in_favor(9).should == 3
      proposal.total_representatives_against(9).should == 3
      proposal.total_representatives_abstention(9).should == 3
    end
    
    it "calculates when even percentage of citizen vote and odd number of representatives" do
      proposal = create_proposal(:title => "free WI-FI", 
                                 :in_favor   => 10, 
                                 :against    => 10, 
                                 :abstention => 0)
      proposal.total_representatives_in_favor(9).should == 4
      proposal.total_representatives_against(9).should == 4
      proposal.total_representatives_abstention(9).should == 0
      
      #making sure 0.49 rounds down
      proposal = create_proposal(:title => "free WI-FI", 
                                 :in_favor   => 49, 
                                 :against    => 49, 
                                 :abstention => 1)
      proposal.total_representatives_in_favor(9).should == 4
      proposal.total_representatives_against(9).should == 4
      proposal.total_representatives_abstention(9).should == 0
      
      
      proposal = create_proposal(:title => "free WI-FI", 
                                 :in_favor   => 18, 
                                 :against    => 82, 
                                 :abstention => 0)
      proposal.total_representatives_in_favor(10).should == 1
      proposal.total_representatives_against(10).should == 8
      proposal.total_representatives_abstention(10).should == 0
      
      proposal = create_proposal(:title => "free WI-FI", 
                                 :in_favor   => 18, 
                                 :against    => 82, 
                                 :abstention => 0)
      proposal.total_representatives_in_favor(9).should == 1
      proposal.total_representatives_against(9).should == 7
      proposal.total_representatives_abstention(9).should == 0
      
      proposal = create_proposal(:title => "free WI-FI", 
                                 :in_favor   => 10, 
                                 :against    => 10, 
                                 :abstention =>10)
      proposal.total_representatives_in_favor(20).should == 6
      proposal.total_representatives_against(20).should == 6
      proposal.total_representatives_abstention(20).should == 6
    end
    
    it "returns zero when there are no votes for a proposal" do
      proposal = create_proposal(:title => "free WI-FI", 
                                 :in_favor   => 0, 
                                 :against    => 0, 
                                 :abstention => 0)
      proposal.total_representatives_in_favor(1).should == 0
      proposal.total_representatives_against(1).should == 0
      proposal.total_representatives_abstention(1).should == 0
    end
  end
end