# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Admin can close proposals", %q{
  In order to finish an opened proposal
  As an admin
  I want to close a proposal
} do

  background do
    @user  = create_user(:login => "123456789A")
    @admin = create_user(:login => "Administreitor", :admin => true)
  end

  scenario "Admin can see the finish button" do
    login_as @admin
    proposal = create_proposal(:title => "Ley Sinde")
    visit proposal_path(proposal)
    page.should have_css('form.button_to')
  end

  scenario "User cannot see the finish button" do
    login_as @user
    proposal = create_proposal(:title => "Ley Sinde")
    visit proposal_path(proposal)
    page.should_not have_css('form.button_to')
  end

  scenario "Admin can finish a proposal" do
    login_as @admin
    proposal = create_proposal(:title => "Ley Sinde")
    visit proposal_path(proposal)
    click_button("Finalizar votaci&oacute;n")
    page.should have_content('El periodo de votación para esta propuesta finalizó')
  end

  scenario "User cannot finish a proposal" do
    login_as @user
    proposal = create_proposal(:title => "Ley Sinde")
    # Hacker-proof
    page.driver.post toggle_proposal_path(proposal)
    page.should have_content("You are being redirected")
  end

  scenario "Admin cannot finish a closed proposal" do
    login_as @admin
    proposal = create_proposal(:title => "Ley Sinde", :closed_at => DateTime.now, :closer_id => @admin.id)
    visit proposal_path(proposal)
    page.should_not have_css('form.button_to')
  end
  
end