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
save_and_open_page  
  page.should have_content("Estoy logueado como Bad Ass Mother Fucking Real User")
end

  scenario "Invalid authentication"
  
end


  
