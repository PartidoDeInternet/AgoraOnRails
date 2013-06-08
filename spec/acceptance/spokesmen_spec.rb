# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Spokesmen", %q{
  In order to create a chain of trust
  As a user
  I want to choose my spokesman
} do
  
  background do
    @user = create_user
  end
  
  scenario "View Users" do
    zapatero = create_user :name => "Jose Luis"
    rajoy = create_user :name => "Mariano"
    
    visit "/"
    click_link "Usuari@s"

    page.should have_link "Jose Luis", :href => user_path(zapatero)
    page.should have_link "Mariano",   :href => user_path(rajoy)
  end
    
  scenario "Choose spokesman" do
    fan_de_punset = create_user :name => "Fan de Punset"
    login_as @user
    
    visit users_path
    click_link "Fan de Punset"
    click_link "Elegir a Fan de Punset como mi portavoz"
    
    page.should have_content "Vas a elegir a Fan de Punset como tu Portavoz"
    click_button "Estoy seguro"
    
    page.should have_content("Has elegido a tu portavoz.")
    @user.reload
    @user.spokesman.should == fan_de_punset
  end
  
  scenario "Discharge spokesman" do
    zapatero = create_user :name => "Zapatero"
    @user.spokesman = zapatero
    @user.save!
    
    login_as @user
    
    visit users_path
    click_link "Zapatero"
    click_link "Destituir a Zapatero de ser mi portavoz"

    page.should have_content("Has destituido a tu portavoz.")

    @user.reload
    @user.spokesman.should == nil
  end
  
  scenario "Display the correct button in a spokeman's page" do
    rajoy = create_user :name => "Rajoy"
    zapatero = create_user :name => "Zapatero"
    
    @user.spokesman = zapatero
    @user.save!
    
    login_as @user

    visit user_path(zapatero)
    page.should have_css(".discharge-my-spokesman")
    
    visit user_path(rajoy)
    page.should have_css(".make-my-spokesman")
    page.should_not have_css(".discharge-my-spokesman")
  end
  
  scenario "Don't allow to choose spokesman unless user is logged in", :js do
    fan_de_punset = create_user :name => "Fan de Punset"
    
    visit users_path
    click_link "Fan de Punset"
    click_link "Elegir a Fan de Punset como mi portavoz"

    page.should have_content("Entra en Agoraonrails")
    page.should_not have_content("Has elegido a tu portavoz.")

    login_with_form_as(@user)
    click_button "Estoy seguro"
    page.should have_content("Has elegido a tu portavoz.")
  end

  context "logged in" do
    scenario "Don't allow to choose myself as a my own spokesman" do
      login_as @user
      visit user_path(@user)
      page.should_not have_css(".make-my-spokesman")
    end
  end

  context "logged out" do
    scenario "Don't allow to choose myself as a my own spokesman", :js do
      visit user_path(@user)   
      click_link "Elegir a #{@user.name} como mi portavoz"
     
      login_with_form_as(@user)

      click_button "Estoy seguro"
      page.should have_content("No puedes ser tu propio portavoz.")
    end

  end

  # refactor
  scenario "View proposals voted by the user" do
    [["Ley Sinde",           "no",         "En contra",  "voted_against",    "Because..."], 
     ["Wifi gratis",         "si",         "A favor",    "voted_in_favor",   "In my opinion..."], 
     ["Ley que no entiendo", "abstencion", "Abstención", "voted_abstention", "I believe..."]].each do | title, vote, humanize_vote_text, css_image, explanation |
 
      proposal = create_proposal :title => title
      create_vote :user => @user, :proposal => proposal, :value => vote, :explanation => explanation
      
      visit user_path(@user)
      
      page.should have_css(".proposal")
      within(:css, "#proposal_#{proposal.id}") do
        page.should have_css(".title",                     :text => title)
        page.should have_css(".#{css_image}",              :text => humanize_vote_text)           
        page.should have_css(".vote-results .explanation", :text => explanation)
      end
    end
  end
  
  scenario "Update vote count when a spokesman is chosen" do
    free_wifi = create_proposal :title => "Wifi Gratis en toda España"
    punset = create_user :name => "Punset" 
    create_vote :proposal => free_wifi, :user => punset, :value => "si"
    
    visit user_path(punset)
    
    within(:css, "#proposal_#{free_wifi.id}") do
      page.should have_css(".in_favor span.vote_count", :text => "1 votos")
    end
    
    login_as @user
    visit user_path(punset)
    click_link "Elegir a Punset como mi portavoz"
    click_button "Estoy seguro"
    
    visit user_path(punset)

    within(:css, "#proposal_#{free_wifi.id}") do
      page.should have_css(".in_favor span.vote_count", :text => "2 votos")
      page.should have_css(".in_favor span.vote_percentage", :text => "100%")
    end
  end
  
  context "Change spokesman" do
    background do
      @free_wifi = create_proposal :title => "Wifi Gratis en toda España"
      @free_cigars = create_proposal :title => "Puros Gratis en toda España"
      @punset = create_user :name => "Punset"
      @rajoy = create_user :name => "Rajoy"
      @fan_de_punset = create_user :name => "Fan de Punset", :spokesman => @punset
      create_vote :proposal => @free_wifi, :user => @punset, :value => "si"
      create_vote :proposal => @free_cigars, :user => @rajoy, :value => "si"
    end
    
    scenario "Update vote count" do
    
      login_as @fan_de_punset
      visit user_path(@rajoy)
      click_link "Elegir a Rajoy como mi portavoz"
    
      page.should have_content("Tu portavoz actual es Punset")
      click_button "Estoy seguro"
    
      page.should have_content("Has cambiado de portavoz.")
    
      visit proposal_path(@free_wifi)

      page.should have_css(".in_favor", :text => "1 votos")
      page.should have_css(".against", :text => "0 votos")
      page.should have_css(".abstention", :text => "0 votos")
    
      visit proposal_path(@free_cigars)

      page.should have_css(".in_favor", :text => "2 votos")
      page.should have_css(".against", :text => "0 votos")
      page.should have_css(".abstention", :text => "0 votos")
    end
  
    scenario "Do not update vote count for closed proposals" do
      @free_cigars.update_attribute :closed_at, Time.now
      
      login_as @fan_de_punset
      visit user_path(@rajoy)
      click_link "Elegir a Rajoy como mi portavoz"
    
      page.should have_content("Tu portavoz actual es Punset")
      click_button "Estoy seguro"
    
      page.should have_content("Has cambiado de portavoz.")
    
      visit proposal_path(@free_wifi)

      page.should have_css(".in_favor", :text => "1 votos")
      page.should have_css(".against", :text => "0 votos")
      page.should have_css(".abstention", :text => "0 votos")
    
      visit proposal_path(@free_cigars)

      page.should have_css(".in_favor", :text => "1 votos")
      page.should have_css(".against", :text => "0 votos")
      page.should have_css(".abstention", :text => "0 votos")
    end
  end
  
  scenario "Update vote count when spokesman votes in the future" do
    free_wifi = create_proposal :title => "Wifi Gratis en toda España"
    punset = create_user :name => "Punset"
    fan_de_punset = create_user :name => "Fan de Punset", :spokesman => punset
    
    login_as punset
    visit proposal_path(free_wifi)
    
    click_link "Sí"
    click_button "Estoy seguro"
    
    visit proposal_path(free_wifi)
    page.should have_css(".in_favor", :text => "2 votos")
  end  
  
  scenario "Update vote count when a spokesman is discharged" do
    zapatero = create_user :name => "Zapatero" 
    @user.spokesman = zapatero
    @user.save!
    
    economia_sostenible = create_proposal :title => "Ley de Economia sostenible"
    create_vote :proposal => economia_sostenible, :user => zapatero, :value => "si"

    economia_sostenible.count_votes!

    visit user_path(zapatero)

    within(:css, "#proposal_#{economia_sostenible.id}") do
      page.should have_css(".in_favor span.vote_count", :text => "2 votos")
    end
    
    login_as @user
    visit user_path(zapatero)
    click_link "Destituir a Zapatero de ser mi portavoz"
    
    visit proposal_path(economia_sostenible)
    within(:css, "#proposal_#{economia_sostenible.id}") do
      page.should have_css(".in_favor span.vote_count", :text => "1 votos")
      page.should have_css(".in_favor span.vote_percentage", :text => "100%")
    end
  end
    
  scenario "Update vote percentages when a spokesman is chosen/discharged" do    
    free_wifi = create_proposal :title => "Wifi Gratis en toda España"
    punset = create_user :name => "Punset" 
    telefonica = create_user :name => "Telefonica" 

    create_vote :proposal => free_wifi, :user => punset, :value => "si"
    create_vote :proposal => free_wifi, :user => telefonica, :value => "no"
    
    login_as @user
    visit user_path(punset)
    
    percentages_should_be(free_wifi, :in_favor => 50, :against => 50, :abstention => 0)
    
    click_link "Elegir a Punset como mi portavoz"
    click_button "Estoy seguro"
    
    visit user_path(punset)
    percentages_should_be(free_wifi, :in_favor => 67, :against => 33, :abstention => 0)

    
    click_link "Destituir a Punset de ser mi portavoz"
    visit user_path(punset)
    percentages_should_be(free_wifi, :in_favor => 50, :against => 50, :abstention => 0)
  end

  context "Transitive delegation" do
    
    scenario "Spokesman chooses spokesman" do
      punset = create_user :name => "Punset"
      fan_de_punset = create_user :name => "Fan de Punset", :spokesman => punset
    
      login_as @user
    
      visit users_path
      click_link "Fan de Punset"
      click_link "Elegir a Fan de Punset como mi portavoz"
      click_button "Estoy seguro"
      
      page.should have_content("Has elegido a tu portavoz.")
      @user.reload
      @user.spokesman.should == fan_de_punset
    end

    scenario "Update vote count when a transitive spokesman is chosen" do
      free_wifi = create_proposal :title => "Wifi Gratis en toda España"
      punset = create_user :name => "Punset"
      fan_de_punset = create_user :name => "Fan de Punset"
      create_vote :proposal => free_wifi, :user => punset, :value => "si"    
    
      login_as fan_de_punset
      visit user_path(punset)
    
      click_link "Elegir a Punset como mi portavoz"
      click_button "Estoy seguro"
    
      login_as @user
      visit user_path(fan_de_punset)
      click_link "Elegir a Fan de Punset como mi portavoz"
      click_button "Estoy seguro"
      
      visit user_path(punset)
    
      within(:css, "#proposal_#{free_wifi.id}") do
        page.should have_css(".in_favor span.vote_count", :text => "3 votos")
        page.should have_css(".in_favor span.vote_percentage", :text => "100%")
      end
    end
    
    scenario "Update vote count when a transitive spokesman is discharged" do
      free_wifi = create_proposal :title => "Wifi Gratis en toda España"
      punset = create_user :name => "Punset"
      fan_de_punset = create_user :name => "Fan de Punset", :spokesman => punset
      create_vote :proposal => free_wifi, :user => punset, :value => "si"

      login_as @user
      
      visit user_path(fan_de_punset)
      click_link "Elegir a Fan de Punset como mi portavoz"
      click_button "Estoy seguro"
      
      visit user_path(fan_de_punset)
      click_link "Destituir a Fan de Punset de ser mi portavoz"
      page.should have_content("Has destituido a tu portavoz.")
      
      visit proposal_path(free_wifi)
      page.should have_css(".in_favor span.vote_count", :text => "2 votos")
      page.should have_css(".in_favor span.vote_percentage", :text => "100%") 
    end
    
    scenario "Delegation cycles are allowed but doesn't count votes if nobody votes" do
      free_wifi = create_proposal :title => "Wifi Gratis en toda España"
      punset = create_user :name => "Punset", :spokesman => @user
      fan_de_punset = create_user :name => "Fan de Punset", :spokesman => punset
      
      login_as @user
      visit user_path(fan_de_punset)
      
      click_link "Elegir a Fan de Punset como mi portavoz"    
      click_button "Estoy seguro"
      
      visit proposal_path(free_wifi)
      
      page.should have_css(".in_favor span.vote_count", :text => "0 votos")
      page.should have_css(".against span.vote_count", :text => "0 votos")
      page.should have_css(".abstention span.vote_count", :text => "0 votos")
    end
    
    scenario "Delegation cycles count votes if one spokesman votes" do
      free_wifi = create_proposal :title => "Wifi Gratis en toda España"
      punset = create_user :name => "Punset", :spokesman => @user
      fan_de_punset = create_user :name => "Fan de Punset", :spokesman => punset
      create_vote :proposal => free_wifi, :user => punset, :value => "si"
      
      login_as @user
      visit user_path(fan_de_punset)
      
      click_link "Elegir a Fan de Punset como mi portavoz"    
      click_button "Estoy seguro"
      
      visit proposal_path(free_wifi)
      
      page.should have_css(".in_favor span.vote_count", :text => "3 votos")
      page.should have_css(".against span.vote_count", :text => "0 votos")
      page.should have_css(".abstention span.vote_count", :text => "0 votos")
    end
    
    scenario "Delegation cycles count votes if two spokesman votes" do
      free_wifi = create_proposal :title => "Wifi Gratis en toda España"
      punset = create_user :name => "Punset", :spokesman => @user
      fan_de_punset = create_user :name => "Fan de Punset", :spokesman => punset
      create_vote :proposal => free_wifi, :user => punset, :value => "si"
      create_vote :proposal => free_wifi, :user => fan_de_punset, :value => "no"
      
      login_as @user
      visit user_path(fan_de_punset)
      
      click_link "Elegir a Fan de Punset como mi portavoz"    
      click_button "Estoy seguro"
      
      visit proposal_path(free_wifi)
      
      page.should have_css(".in_favor span.vote_count", :text => "1 votos")
      page.should have_css(".against span.vote_count", :text => "2 votos")
      page.should have_css(".abstention span.vote_count", :text => "0 votos")
    end
    
  end
end
