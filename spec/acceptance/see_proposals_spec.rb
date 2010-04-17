require File.dirname(__FILE__) + '/acceptance_helper'

feature "See proposals", %q{
  In order to make an informed decision regarding my vote
  As a citizen
  I want to see all the relevant information about a proposal
} do
  
  scenario "See a proposal basic information" do
    # Given we have a proposal
    proposal = create_proposal(:title => "Ley Sinde", :official_url => "http://congreso.es/sinde", :proposal_type => "Proyecto de Ley")
    
    # When I go to the proposal´s page
    visit proposal_path(proposal)
    
    # Then I should see the relevant information about a proposal
    page.should have_css(".proposal", :count => 1) do |proposal|
      proposal.should have_css(".proposal_type", :content => "Proyecto de Ley")
      proposal.should have_css(".title", :content => "Ley Sinde")
      proposal.should have_css(".official_url", :content => "Enlace oficial", :href => "http://congreso.es/sinde")
    end
  end
  
end