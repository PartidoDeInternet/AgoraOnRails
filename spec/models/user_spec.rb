require File.dirname(__FILE__) + "/../spec_helper"

describe User do
  it "could have a representer" do
    organization = create_organization(:name => "Greenpeace")
    user = create_user(:representer => organization)
    user.representer.should == organization
    organization.represented_users.should include(user)
  end
  
  it "could represent an organization" do
    zp = create_user(:first_name => "Jose Luis", :last_name => "Zapatero")
    psoe = create_organization(:name => "PSOE", :spokesman => zp)
    zp.represented_organization.should == psoe
  end
  
  it "should not have delegated opinion if she has already voted" do
    user = create_user
    ley_sinde = create_proposal
    create_vote(:user => user, :proposal => ley_sinde, :value => 'no')
    user.delegated_opinion_for(ley_sinde).should == nil
  end
end