# encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Insert proposal manually", %q{
  In order to have new proposals in Agora
  As a district administrator
  I want to insert new propositions
} do
  
  scenario "insert a new proposal" do
    admin = create_user :admin => true
    economia = create_category :name => 'Economía y Hacienda'
    pdi = create_proposer :name      => 'Partido de Internet',
                          :full_name => 'Partido de Internet'
    
    login_as admin
    
    visit new_proposal_path
    
    fill_in 'Title', :with => 'Derogación de la Ley Sinde'    
    fill_in 'Official url', :with => 'http://partidodeinternet.es'
    fill_in 'Proposal type', :with => 'Proposición de ley'
    
    select economia.name, :from => 'proposal_category_id'
    select pdi.full_name, :from => 'proposal_proposer_id'
    
    select '12',   :from => 'proposal_proposed_at_3i'
    select 'Abril',    :from => 'proposal_proposed_at_2i'
    select '2011', :from => 'proposal_proposed_at_1i'

    click_button 'Crear'

    proposal = Proposal.last
    proposal.title.should == 'Derogación de la Ley Sinde'
    proposal.official_url.should == 'http://partidodeinternet.es'
    proposal.proposal_type.should == 'Proposición de ley'
    
    proposal.category.should == economia
    proposal.proposer.should == pdi
    
    page.current_path.should == proposal_path(proposal)
    page.should have_content proposal.title
  end
end