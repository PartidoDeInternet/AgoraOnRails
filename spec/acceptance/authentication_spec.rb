# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Authentication", %q{
  In order to keep track of what proposals I have voted
  As a citizen
  I want to sign in and out of the application
} do

  background do
    @user  = create_user(:name => "123456789A")
  end

  scenario "Sign in with twitter" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:twitter, {:user_info => {:name => "José Luis Sampedro"}})
    visit "/user_session/new"
    click_link "Sign in with Twitter"
    page.should have_content "José Luis Sampedro"
  end

  scenario "Sign in with tractis" do
    user = create_user
    stub_tractis_request
    get_tractis_callback(user.name, user.uid)
    visit "/"
    page.should have_content "Estoy logueado como Mother Fucking Real User"
  end

  scenario "Sign out" do
    user = create_user
    login_as user
    visit "/"
    click_link "quiero salir de la applicación"
    page.should_not have_content "Estoy logueado como Mother Fucking Real User"
    page.should have_content "oh! adios :("
  end
end
