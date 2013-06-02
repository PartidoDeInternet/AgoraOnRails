# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "DNI authentication", %q{
  In order to have real votes
  As a real mother fucking user
  I want to authenticate myself with my DNI
} do

  background do
pending "Tractis gem implmementation"
  end

  scenario "Valid authentication with new user" do
    visit login_path
  
    page.should have_css("input[@value='Identifícate con tu DNIe']")
    
    register_with_tractis_as("Bad Ass Mother Fucking New User", "12345678V")
    
    page.should have_content I18n.t(:currently_logged_as, :username => "Bad Ass Mother Fucking New User")
  end

  context "Anonymity" do
    scenario "Should not store the user DNI and name" do
      register_with_tractis_as("Bad Ass Mother Fucking New User", "12345678V")
      User.count.should == 1
      User.first.name.should_not == "Bad Ass Mother Fucking New User"
      User.first.dni.should_not == "12345678V"
    end
  
    scenario "Should create two different users when loging in twice with the same DNI" do
      register_with_tractis_as("Bad Ass Mother Fucking New User", "12345678V")
      register_with_tractis_as("Bad Ass Mother Fucking New User", "12345678V")
      User.count.should == 2
    end
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
pending "Tractis gem implementation"    
    visit new_user_session_path
    fill_in 'name', :with => 'Backdoor Mother Fucker'
    click_button 'Haz tongo aquí'

    page.should have_content(I18n.t(:currently_logged_as, :username => 'Backdoor Mother Fucker'))
  end
end


  
