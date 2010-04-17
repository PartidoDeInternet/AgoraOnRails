require File.dirname(__FILE__) + '/acceptance_helper'

feature "Vote for proposals", %q{
  In order to change the mother fucking world
  As a citizen
  I want to vote for/against proposals
} do
  
  scenario "Vote for open proposals" do
    proposal = create_proposal(:title => "Ley Sinde")
    
    visit proposal_path(proposal)
    click_button "No"
    
    page.should have_content("Vas a votar en contra de la iniciativa “Ley Sinde”")
    
    click_button "Confirmar"
    
    page.should have_content("Tu voto ha sido contabilizado.")
  end

  scenario "Can't vote for closed proposals"
 
  scenario "Can't vote twice for the same proposal"  
end