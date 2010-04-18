require File.dirname(__FILE__) + '/acceptance_helper'

feature "See proposals", %q{
  In order to make an informed decision regarding my vote
  As a citizen
  I want to see all the relevant information about a proposal
} do
  
  scenario "See a proposal basic information" do
    # Given we have a proposal
    proposal = create_proposal(:title => "Ley Sinde", :official_url => "http://congreso.es/sinde", :proposal_type => "Proyecto de Ley")
     
    3.times { create_vote(:proposal => proposal) }
    5.times { visit proposal_path(proposal) }
    # When I go to the proposal´s page
    visit proposal_path(proposal)
    
    # Then I should see the relevant information about a proposal
    page.should have_css(".proposal", :count => 1)
    within(:css, ".proposal") do
      page.should have_css(".proposal_type", :text => "Proyecto de Ley")
      page.should have_css(".title", :text => "Ley Sinde")
      page.should have_css(".official_url", :text => "Enlace oficial", :href => "http://congreso.es/sinde")
      page.should have_css(".votes", :text => "3 votos")
      page.should have_css(".views", :text => "5 visitas")
    end
  end
  
end