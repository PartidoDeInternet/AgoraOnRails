require File.dirname(__FILE__) + '/acceptance_helper'

feature "Home page", %q{
  In order to attract people to come back to the app
  As a citizen
  I want to see most interesting proposals in the home page
} do
  
  scenario "Hot proposals" do
    create_proposal(:title => "Legalize it",         :ranking => 8)
    create_proposal(:title => "Cafe para todos",     :ranking => 4)
    create_proposal(:title => "Zapatero Dimisión",   :ranking => 7)
    create_proposal(:title => "Ley Sinde",           :ranking => 10)
    create_proposal(:title => "Bajar el IVA",        :ranking => 6)
    create_proposal(:title => "WIFI en todo Madrid", :ranking => 5)
    
    visit homepage
    
    should_see_hot_proposals(["Ley Sinde", "Legalize it", "Zapatero Dimisión", 
                              "Bajar el IVA", "WIFI en todo Madrid"])
    
    page.should have_css("#hot_proposals .proposal", :count => 5)
    page.should have_css("#hot_proposals .proposal:first .title", :text => "Ley Sinde")
    
  end
  
  scenario "Proposal information" do
    create_proposal :title => "Ley Sinde",
                    :proposer => create_proposer(:name => "Gobierno"),
                    :proposed_at => Date.new(2010, 4, 24)
    
    visit homepage
    
    page.should have_css(".proposal .title", :text => "Ley Sinde")
    page.should have_css(".proposal .proposer", :text => "Gobierno")
    page.should have_css(".proposal .proposed_at", :text => "24 de Abril de 2010")
  end
  
  scenario "Recently closed proposals" do
    create_proposal :title => "Legalize it",         :closed_at => 20.days.ago.to_date
    create_proposal :title => "Cafe para todos",     :closed_at => 15.days.ago.to_date
    create_proposal :title => "Zapatero Dimisión",   :closed_at => 23.days.ago.to_date
    create_proposal :title => "Juanjo for president"
    create_proposal :title => "WIFI en todo Madrid", :closed_at => 1.days.ago.to_date
    create_proposal :title => "Ley Sinde",           :closed_at => 2.days.ago.to_date
    create_proposal :title => "Bajar el IVA",        :closed_at => 5.days.ago.to_date
    
    visit homepage
    click_link "Recién tramitadas"

    page.should have_css("#recently_closed .proposal", :count => 5)
    page.should have_css("#recently_closed .proposal:first .title", :text => "WIFI en todo Madrid")
  end
  
  scenario "Categories" do
    economy   = create_category(:name => "Economy")
    health    = create_category(:name => "Health")
    education = create_category(:name => "Education")
    culture   = create_category(:name => "Culture")
    defense   = create_category(:name => "Defense")
    justice   = create_category(:name => "Justice")
    
    2.times { create_proposal(:category => economy) }
    2.times { create_proposal(:category => health) }
    3.times { create_proposal(:category => education) }
    2.times { create_proposal(:category => culture) }
    1.times { create_proposal(:category => defense) }
    2.times { create_proposal(:category => justice) }
    
    visit homepage
    
    page.should have_css("#categories .category", :count => 5)
    page.should have_css("#categories .category:first .name", :text => "Education")
    page.should have_css("#categories .category:first .count", :text => "3")
    page.should_not have_css("#categories .category", :text => "Defense")
  end
  
  scenario "Proposers" do
    psoe     = create_proposer(:name => "PSOE")
    pp       = create_proposer(:name => "PP")
    pnv      = create_proposer(:name => "PNV")
    iu       = create_proposer(:name => "IU")
    gobierno = create_proposer(:name => "Gobierno")
    senado   = create_proposer(:name => "Senado")
    
    2.times { create_proposal(:proposer => psoe) }
    2.times { create_proposal(:proposer => pp) }
    3.times { create_proposal(:proposer => pnv) }
    2.times { create_proposal(:proposer => iu) }
    1.times { create_proposal(:proposer => gobierno) }
    2.times { create_proposal(:proposer => senado) }
    
    visit homepage

    page.should have_css("#proposers .proposer", :count => 5)
    page.should have_css("#proposers .proposer:first .name", :text => "PNV")
    page.should have_css("#proposers .proposer:first .count", :text => "3")
    page.should_not have_css("#proposers .proposer", :text => "Gobierno")
  end
  
  scenario "Vote count" do
    visit homepage
    
    page.should have_content("0 votos a través de populo")
    
    3.times { create_vote }
    
    visit homepage
    
    page.should have_content("3 votos a través de populo")
  end
  
end