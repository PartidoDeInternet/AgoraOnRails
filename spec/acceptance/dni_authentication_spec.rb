# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "DNI authentication", %q{
  In order to have real votes
  As a real mother fucking user
  I want to authenticate myself with my DNI
} do

  scenario "Valid authentication with new user" do
    visit login_path
  
    page.should have_css("input[@value='Identifícate con tu DNIe']")
    
    register_with_tractis_as("Bad Ass Mother Fucking New User", "12345678V")

    page.should have_content I18n.t(:currently_logged_as, :name => "Bad Ass Mother Fucking New User")
  end

  scenario "Should store the user DNI and name" do
    register_with_tractis_as("Bad Ass Mother Fucking New User", "12345678V")
    User.count.should == 1
    User.first.name.should == "Bad Ass Mother Fucking New User"
    User.first.uid.should  == "12345678V"
  end

  scenario "Should find the user from a DNI number" do
    register_with_tractis_as("Bad Ass Mother Fucking New User", "12345678V")
    click_link "quiero salir de la applicación"
    login_with_tractis_as(User.last)
    page.should have_content I18n.t(:currently_logged_as, :name => "Bad Ass Mother Fucking New User")
    User.count.should == 1
  end

  scenario "Invalid authentication" do
    hack_attempt_to_reproduce_tractis_callback
    
    page.should have_content("Access Denied Bitch")
  end
  
end


  
