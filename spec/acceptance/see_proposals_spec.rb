require File.dirname(__FILE__) + '/acceptance_helper'

feature "See proposals", %q{
  In order to make an informed decision regarding my vote
  As a citizen
  I want to see all the relevant information about a proposal
} do
  
  background do
    @proposal = create_proposal(
               :title => "Ley Sinde", 
               :official_url => "http://congreso.es/sinde", 
               :proposal_type => "Proyecto de Ley")
  end
  
  scenario "See a proposal basic information" do
    3.times { create_vote(:proposal => @proposal) }
    5.times { visit proposal_path(@proposal) }

    visit proposal_path(@proposal)

    page.should have_css(".proposal", :count => 1)
    within(:css, ".proposal") do
      page.should have_css(".proposal_type", :text => "Proyecto de Ley")
      page.should have_css(".title", :text => "Ley Sinde")
      page.should have_css(".official_url", :text => "Enlace oficial", :href => "http://congreso.es/sinde")
      page.should have_css(".votes", :text => "3 votos")
      page.should have_css(".views", :text => "5 visitas")
    end
  end
  
  scenario "See comments and links for a proposal" do
    punset  = create_user(:login => "Punset")

    punsets_vote = create_vote(
      :user        => punset,
      :proposal    => @proposal, 
      :explanation => "Internet es un derecho fundamental de todos los humanos",
      :link        => "http://derechoshumanos.com")
                    
    visit proposal_path(@proposal)

    within(:css, ".proposal") do      
      within(:css, "#vote_#{punsets_vote.id}") do 
        page.should have_css(".login", :text => "Punset")
        page.should have_css(".login a", :href => "users/#{punset.id}")
        page.should have_css(".explanation", :text => "Internet es un derecho fundamental de todos los humanos")
        page.should have_css(".link", :text => "http://derechoshumanos.com")
      end
    end
  end

  scenario "Only displays votes with a comment" do
    trol = create_user(:login => "Trol")
 
    trols_vote = create_vote( 
       :user        => trol,
       :proposal    => @proposal, 
       :link        => "http://youporn.com")
    
    visit proposal_path(@proposal)
        
    within(:css, ".proposal") do
      page.should_not have_css(".login", :text => "Trol")
      page.should_not have_css(".link", :text => "http://youporn.com")
    end
  end
  
  scenario "Order comments by number of represented users" do
    jenny = create_user(:login => "Jenny")
    1.times { create_user :spokesman => jenny}
    
    jonnhy = create_user(:login => "Jonnhy")
    3.times { create_user :spokesman => jonnhy}
    
    punset = create_user(:login => "Punset")
    10.times { create_user :spokesman => punset}
    
    [jenny, punset, jonnhy].each { |user| 
      create_vote :user => user, :proposal => @proposal, :explanation => "#{user.login}'s explanation" }
    
    visit proposal_path(@proposal)

    within(:css, ".proposal") do           
      page.should have_css(".vote:nth-child(5) .explanation", :text => "Punset's explanation")
      page.should have_css(".vote:nth-child(6) .explanation", :text => "Jonnhy's explanation")
      page.should have_css(".vote:nth-child(7) .explanation", :text => "Jenny's explanation")
    end
    
  end
  
end