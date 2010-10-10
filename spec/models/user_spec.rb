require File.dirname(__FILE__) + "/../spec_helper"

describe User do
  it "could have a representer" do
    buenafuente = create_user(:login => "Buenafuente")
    user = create_user(:spokesman => buenafuente)
    user.spokesman.should == buenafuente
    buenafuente.represented_users.should include(user)
  end
    
  it "should not have delegated opinion if she has already voted" do
    user = create_user
    ley_sinde = create_proposal
    create_vote(:user => user, :proposal => ley_sinde, :value => 'no')
    user.delegated_opinion_for(ley_sinde).should == nil
  end
end