# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Authentication", %q{
  In order to keep track of what proposals I have voted
  As a citizen
  I want to basic authentication funcionalities
} do

  scenario "Sign up with standard account" do
    visit "/users/sign_in"
    within("#signup") do
      fill_in :user_name, with: "Punset"
      fill_in :user_email, with: "punset@spain.com"
      fill_in :user_password, with: "secret"
      click_button "Sign up"
    end
    page.should have_content "Estoy logueado como Punset"
  end

  scenario "Sign in with standard account", :js do
    user = create_user 
    visit "/users/sign_in"
    click_link "Entra con tu cuenta de Agoraonrails"
    within("#agoraonrails-account") do
      fill_in :user_email, with: user.email
      fill_in :user_password, with: user.password
      click_button "Sign in"
    end
    page.should have_content "Estoy logueado como Mother Fucking Real User"
  end
  
  scenario "Sign in with twitter" do
    user = create_user name: "José Luis Sampedro"
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:twitter, {:uid => user.uid, :info => {:name => user.name}})
    visit "/users/sign_in"
    click_link "twitter_sign_in"
    page.should have_content "José Luis Sampedro"
  end

  scenario "Sign in with facebook" do
    user = create_user name: "Platón"
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:facebook, {:uid => user.uid, :info => {:name => user.name}})
    visit "/users/sign_in"
    click_link "facebook_sign_in"
    page.should have_content "Platón"
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
    page.should have_content "Estoy logueado como Mother Fucking Real User"

    click_link "quiero salir de la applicación"
    page.should have_content "Cerraste sesión correctamente"
    page.should_not have_content "Estoy logueado como Mother Fucking Real User"
  end
  
  scenario "Forgot password for standard account", :js do
    create_user email: "punset@spain.com"
    
    visit "/users/sign_in"
    click_link "Entra con tu cuenta de Agoraonrails"
    click_link "¿Olvidaste tu contraseña?"
    
    within("#forgot-password") do
      fill_in :user_email, with: "punset@spain.com"
      click_button "Restablecer contraseña"
    end
    page.should have_content "Recibirás un email con instrucciones para reiniciar tu contraseña en unos minutos."
  end
end
