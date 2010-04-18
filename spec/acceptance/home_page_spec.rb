require File.dirname(__FILE__) + '/acceptance_helper'

feature "Home page", %q{
  In order to attract people to come back to the app
  As a citizen
  I want to see most interesting proposals in the home page
} do
  
  scenario "Hot proposals" do
    create_proposal(:title => "Ley Sinde",           :ranking => 10)
    create_proposal(:title => "Legalize it",         :ranking => 8)
    create_proposal(:title => "Cafe para todos",     :ranking => 4)
    create_proposal(:title => "Zapatero Dimisión",   :ranking => 7)
    create_proposal(:title => "Bajar el IVA",        :ranking => 6)
    create_proposal(:title => "WIFI en todo Madrid", :ranking => 5)
    
    visit homepage
    
    should_see_hot_proposals(["Ley Sinde", "Legalize it", "Zapatero Dimisión", 
                              "Bajar el IVA", "WIFI en todo Madrid"])
    
    page.should have_css(".hot_proposal", :count => 5)
  end
  
  scenario "Recently closed proposals"
  
  scenario "Categories"
  
  scenario "Proposers"
  
  scenario "Vote count"
  
end