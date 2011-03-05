# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Feature name", %q{
  In order to find the proposals I'm interested in
  As a citizen
  I want to be able to navigate the site in different ways
} do
  
  scenario "Navigate using categories" do
    create_proposal :title => "Ley Sinde", 
                    :category => create_category(:name => "Cultura")
    create_proposal :title => "Usar Google en los examenes", 
                    :category => create_category(:name => "Educación")
    
    visit homepage
    
    click_link "Cultura"

    page.should have_content("Propuestas relacionadas con Cultura")
    page.should have_css(".proposal .title", :text => "Ley Sinde")
    page.should_not have_css(".proposal .title", :text => "Usar Google en los examenes")
    
    click_link "Educación"
    page.should have_content("Propuestas relacionadas con Educación")
    page.should have_css(".proposal .title", :text => "Usar Google en los examenes")
    page.should_not have_css(".proposal .title", :text => "Ley Sinde")
  end
  
  scenario "Navigate using proposers" do
    create_proposal :title => "Ley Sinde", 
                    :proposer => create_proposer(:name => "Gobierno")
    create_proposal :title => "Usar Google en los examenes", 
                    :proposer => create_proposer(:name => "Andalucía")
    
    visit homepage
    
    within(:css, "aside") { click_link "Gobierno" }
    page.should have_content("Propuestas presentadas por Gobierno")
    page.should have_css(".proposal .title", :text => "Ley Sinde")
    page.should_not have_css(".proposal .title", :text => "Usar Google en los examenes")
    
    within(:css, "aside") { click_link "Andalucía" }
    page.should have_content("Propuestas presentadas por Andalucía")
    page.should have_css(".proposal .title", :text => "Usar Google en los examenes")
    page.should_not have_css(".proposal .title", :text => "Ley Sinde")
  end
  
  scenario "Using proposer from a proposal" do
    proposal = create_proposal :proposer => create_proposer(:name => "Gobierno")
    
    visit homepage
    within(:css, ".proposal") { click_link "Gobierno" }
    
    page.should have_content("Propuestas presentadas por Gobierno")
  end
  
  scenario "View all proposals from a single proposal" do
    2.times { create_proposal }
    
    visit proposals_path
    
    page.should have_content("Propuestas")
    page.should have_css(".proposal", :count => 2)
  end
    
end