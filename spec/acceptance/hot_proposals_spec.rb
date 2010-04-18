require File.dirname(__FILE__) + '/acceptance_helper'

feature "Hot Proposals", %q{
  In order know what are the most interesting proposals
  As a citizen
  I want a mechanism to determine what are the hotest proposals
} do
  
  background do
    @proposal = create_proposal
    @user = create_user
    login_as @user
  end
    
  scenario "Ranking should increase by 1 after a visit" do
    lambda do
      visit proposal_path(@proposal)
      @proposal.reload
    end.should change { @proposal.ranking }.by(1)
  end
  
  scenario "Ranking should increase by 3 after a vote" do
    lambda do 
        create_vote(:proposal => @proposal)
        @proposal.reload
    end.should change { @proposal.ranking }.by(3) 
  end
end