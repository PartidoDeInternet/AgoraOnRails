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
      page.should have_link("Enlace oficial", :href => "http://congreso.es/sinde")
      page.should have_css(".votes", :text => "3 votos")
      page.should have_css(".views", :text => "5 visitas")
    end
  end
  
  scenario "See comments for a proposal" do
    punset  = create_user(:name => "Punset")

    punsets_vote = create_vote(
      :user        => punset,
      :proposal    => @proposal, 
      :explanation => "Internet es un derecho fundamental de todos los humanos")
                    
    visit proposal_path(@proposal)

    within(".votes_with_explanations") do      
      within("#vote_#{punsets_vote.id}") do    
        page.should have_css(".login", :text => "Punset")
        page.should have_link(punset.name, :href => "/users/#{punset.id}")
        page.should have_content("Internet es un derecho fundamental de todos los humanos")
      end
    end
  end
  
  scenario "Display links in comments" do
    buenafuente = create_user(:name => "Buenafuente")
 
    buenafuente_vote = create_vote( 
       :user        => buenafuente,
       :proposal    => @proposal,
       :explanation => "En mi último programa http://buenafuente.com hablo sobre esto")
    
    visit proposal_path(@proposal)
          
    within(".votes_with_explanations") do
      page.should have_link("http://buenafuente.com")
    end
  end
  
  scenario "Display new paragraphs in comments" do
    buenafuente = create_user(:name => "Buenafuente")
 
    buenafuente_vote = create_vote( 
       :user        => buenafuente,
       :proposal    => @proposal,
       :explanation => "En mi último programa\n\n hablo sobre esto")
    
    visit proposal_path(@proposal)
    within(".votes_with_explanations") do
      page.should have_css("p.explanation", :count => 2)
    end
  end

  scenario "Only displays votes with a comment" do
    john = create_user(:name => "John")
 
    johns_vote = create_vote( 
       :user        => john,
       :proposal    => @proposal)
    
    visit proposal_path(@proposal)
        
    within(:css, ".proposal") do
      page.should_not have_css(".login", :text => "John")
    end
  end
  
  scenario "Order comments by number of represented users" do
    jenny = create_user(:name => "Jenny")
    1.times { create_user :spokesman => jenny}
    
    jonnhy = create_user(:name => "Jonnhy")
    3.times { create_user :spokesman => jonnhy}
    
    punset = create_user(:name => "Punset")
    10.times { create_user :spokesman => punset}
    
    [jenny, punset, jonnhy].each { |user| 
      create_vote :user => user, :proposal => @proposal, :explanation => "#{user.name}'s explanation" }
    
    visit proposal_path(@proposal)

    within(:css, ".proposal") do        
      explanations = all(".vote .explanation").map(&:text).map(&:strip)
      explanations.first.should == "Punset's explanation"
      explanations.second.should == "Jonnhy's explanation"
      explanations.third.should == "Jenny's explanation"
    end
  end
  
end