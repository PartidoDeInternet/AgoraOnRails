# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Authentication", %q{
  In order to keep track of what proposals I have voted
  As a citizen
  I want to sign in and out of the application
} do

  scenario "Sign in with twitter" do
    user = create_user name: "José Luis Sampedro"
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:twitter, {:uid => user.uid, :user_info => {:name => user.name}})
    visit "/users/sign_in"
    click_link "twitter_sign_in"
    page.should have_content "José Luis Sampedro"
  end

  scenario "Sign in with tractis" do
    user = create_user provider: "tractis" 
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
    page.should have_content "Cerraste sesión correctamente"
  end
end
