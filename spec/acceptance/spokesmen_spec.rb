require File.dirname(__FILE__) + '/acceptance_helper'

feature "Spokesmen", %q{
  In order to create a chain of trust
  As a user
  I want to choose my spokesman
} do
  
  background do
    @user = create_user(:login => "123456789A")
  end
  
  scenario "View Users" do
    zapatero = create_user :first_name => "Jose Luis", :last_name => "Zapatero"
    rajoy = create_user :first_name => "Mariano", :last_name => "Rajoy"
    
    visit "/"
    click_link "Usuarios"

    page.should have_css(".user .name", "PSOE")
    page.should have_css(".user .link", "http://www.psoe.es")
    page.should have_css(".user .spokesman .name", "Nadie")

    page.should have_css(".user .name", "PP")
    page.should have_css(".user .link", "http://www.pp.es")
    page.should have_css(".user .spokesman .name", "Nadie")
  end
    
  scenario "Choose spokesman" do
    fan_de_punset = create_user :login => "Fan de Punset"
    login_as @user
    
    visit users_path
    click_link "Fan de Punset"
    click_button "Elegir a Fan de Punset como mi portavoz"
    
    page.should have_content("Has elegido a tu portavoz.")
    @user.reload
    @user.spokesman.should == fan_de_punset
  end
  
  scenario "Don't allow to choose spokesman unless user is logged in" do
    fan_de_punset = create_user :login => "Fan de Punset"
    
    visit users_path
    click_link "Fan de Punset"
    click_button "Elegir a Fan de Punset como mi portavoz"

    page.should have_content("Autenticación requerida")
    page.should_not have_content("Has elegido a tu portavoz.")
  end
  
  scenario "View proposals voted by the user" do
    [["Ley Sinde",           "no",         "En contra",  "voted_against"], 
     ["Wifi gratis",         "si",         "A favor",    "voted_in_favor"], 
     ["Ley que no entiendo", "abstencion", "Abstención", "voted_abstention"]].each do |title, vote, humanize_vote_text, css_image|
 
      proposal = create_proposal :title => title
      create_vote :user => @user, :proposal => proposal, :value => vote
      
      visit user_path(@user)
      
      page.should have_css(".proposal")
      within(:css, "#proposal_#{proposal.id}") do
        page.should have_css(".title", :text => title)
        page.should have_css(".#{css_image}", :text => humanize_vote_text)
      end
    end
  end
    
end