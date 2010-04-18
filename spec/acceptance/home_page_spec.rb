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
  
  scenario "Recently closed proposals"
  
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
    
    page.should have_css(".category", :count => 5)
    page.should have_css(".category:first .name", :text => "Education")
    page.should have_css(".category:first .count", :text => "3")
    page.should_not have_css(".category", :text => "Defense")
  end
  
  scenario "Proposers"
  
  scenario "Vote count"
  
end