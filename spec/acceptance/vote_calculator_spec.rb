# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Vote calculator", %q{
  In order to vote proportionally to the real vote
  As an representative
  I want to know how many of us should vote yes, no or abstention
} do
  
  scenario "Calculate representative vote distribution" do
    @admin = create_user(:name => "Administreitor", :admin => true)
    login_as @admin
    proposal = create_proposal(:title => "Ley Sinde",
                               :in_favor => 20,
                               :against => 70,
                               :abstention => 10)
    
    visit proposal_path(proposal)
    
    fill_in "representative_count", :with => "10"

    click_button I18n.t(:calculate)
    
    page.should have_css(".representative_count_in_favor", :text => "2")
    page.should have_css(".representative_count_against", :text => "7")
    page.should have_css(".representative_count_abstention",  :text => "1")
  end
end