require File.dirname(__FILE__) + "/../spec_helper"

describe User do
  it "could have a spokesman" do
    buenafuente = create_user(:name => "Buenafuente")
    user = create_user(:spokesman => buenafuente)
    user.spokesman.should == buenafuente
    buenafuente.represented_users.should include(user)
  end

  it "does not allow a user to choose himself as a spokesman" do
    expect{
      buenafuente = create_user(:name => "Buenafuente")
      buenafuente.update_attributes!(:spokesman => buenafuente)
    }.to raise_error
  end

  it "should not have delegated vote if she has already voted" do
    user = create_user
    ley_sinde = create_proposal
    create_vote(:user => user, :proposal => ley_sinde, :value => 'no')
    user.delegated_vote_for(ley_sinde).should == nil
  end

  it "should voted if spokesman voted a proposal" do
    buenafuente = create_user(:name => "Buenafuente")
    user = create_user(:spokesman => buenafuente)
    ley_sinde = create_proposal
    create_vote(:user => buenafuente, :proposal => ley_sinde, :value => 'no')
    user.delegated_vote_for(ley_sinde).value.should == 'no'
  end
end