# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "DNI authentication", %q{
  In order to have real votes
  As a real mother fucking user
  I want to authenticate myself with my DNI
} do
  
  scenario "Valid authentication with existing user" do
    user = create_user(:name => "Bad Ass Mother Fucking Real User")
    visit login_path
  
    page.should have_css("input[@value='Identifícate con tu DNIe']")
    
    login_as user
    
    page.should have_content("Estoy logueado como Bad Ass Mother Fucking Real User")
  end

  scenario "Valid authentication with new user" do
    visit login_path
  
    page.should have_css("input[@value='Identifícate con tu DNIe']")
    
    register_as("Bad Ass Mother Fucking New User", "12345678V")
    
    page.should have_content("Estoy logueado como Bad Ass Mother Fucking New User")
    User.find_by_name_and_dni("Bad Ass Mother Fucking New User", "12345678V").should be
  end

  scenario "Invalid authentication" do
    hack_attempt_to_reproduce_tractis_callback
    
    page.should have_content("Access Denied Bitch")
  end
  
end

feature "Tongo", %q{
  In order to not piss people off with the mother fucking DNI reader
  As a developer
  I want a backdoor...
} do
  
  scenario "Backdoor" do
    visit new_user_session_path
    fill_in 'name', :with => 'Backdoor Mother Fucker'
    click_button 'Haz tongo aquí'

    page.should have_content("Estoy logueado como Backdoor Mother Fucker ")
  end
end


  
