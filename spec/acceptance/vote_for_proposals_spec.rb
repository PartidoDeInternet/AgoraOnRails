# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Vote for proposals", %q{
  In order to change the mother fucking world
  As a citizen
  I want to vote for/against proposals
} do

  background do
    @user = create_user(:dni => "12345678A")
    @user2 = create_user(:dni => "12345678B")
    @user3 = create_user(:dni => "12345678C")
  end

  scenario "Vote for open proposals" do
    login_as @user

    [["no",         I18n.t(:going_to_vote_against)],
     ["si",         I18n.t(:going_to_vote_in_favor)],
     ["abstencion", I18n.t(:going_to_abstain)]].each do |vote, confirmation|

      proposal = create_proposal(:title => "Ley Sinde")

      visit proposal_path(proposal)

      click_button vote

      page.should have_content confirmation
      page.should_not have_content(I18n.t(:because))
      page.should_not have_content(I18n.t(:more_info))

      click_button I18n.t(:i_am_sure)

      page.should have_content(I18n.t(:vote_counted))
      page.should have_css(".share.fb-share iframe")
      page.should have_css(".share.twitter-share iframe")
    end
  end

  scenario "Add an optional explanation to your vote" do
    login_as @user
    proposal = create_proposal(:title => "Ley Sinde")
    explanation = "we don't want the ignorance in 'A Brave New World'"

    visit proposal_path(proposal)
    fill_in I18n.t(:explain), :with => explanation
    click_button I18n.t(:yes_option)

    page.should have_content(I18n.t(:because, :explanation => explanation))
    page.should_not have_content(I18n.t(:more_info))

    click_button I18n.t(:i_am_sure)

    @user.votes.last.explanation.should == explanation
  end

  scenario "Add an optional link to your vote" do
    login_as @user
    proposal = create_proposal(:title => "Ley Sinde")
    link = "http://en.wikipedia.org/wiki/Brave_New_World"

    visit proposal_path(proposal)
    fill_in "link", :with => link
    click_button I18n.t(:yes_option)

    page.should have_content("Más información #{link}")
    page.should_not have_content I18n.t(:because)
    click_button I18n.t(:i_am_sure)

    @user.votes.last.link.should == link
  end

  scenario "Can't vote if i'm not logged in" do
    proposal = create_proposal(:title => "Derogación del canon")

    visit proposal_path(proposal)
    click_button I18n.t(:yes_option)

    page.should have_content I18n.t(:auth_required)
    page.should_not have_css("button", :text => I18n.t(:i_am_sure))
      
    login_as @user

    page.should have_content("Vas a votar a favor de la iniciativa “Derogación del canon”")
  end

  scenario "Can't vote for closed proposals" do
    proposal = create_proposal(:closed_at => Date.yesterday, :official_resolution => "Derogada")

    login_as @user
    visit proposal_path(proposal)

    page.should have_content("La Propuesta fue Derogada en el Congreso")

    page.should_not have_css("button", :text => "Sí")
    page.should_not have_css("button", :text => "No")
    page.should_not have_css("button", :text => "Abstención")

    # Hacker-proof
    page.driver.post proposal_votes_path(proposal), :vote => {}
    Vote.count.should == 1
  end

  scenario "Can't vote twice for the same proposal" do
    proposal = create_proposal(:title => "Derogación del canon")

    login_as @user
    visit proposal_path(proposal)

    click_button I18n.t(:yes_option)
    click_button I18n.t(:i_am_sure)

    visit proposal_path(proposal)

    page.should have_content("Ya has votado esta propuesta")

    page.should_not have_css("button", :text => "Sí")
    page.should_not have_css("button", :text => "No")
    page.should_not have_css("button", :text => "Abstención")

    page.should have_css(".share.fb-share iframe")
    page.should have_css(".share.twitter-share iframe")

    # Hacker-proof
    page.driver.post proposal_votes_path(proposal), :vote => {}

    Vote.count.should == 1
  end

  scenario "Citizen vote results" do
    login_as @user
    proposal = create_proposal

    visit proposal_path(proposal)

    click_button I18n.t(:yes_option)
    click_button I18n.t(:i_am_sure)

    visit proposal_path(proposal)

    percentages_should_be(proposal, :in_favor => 100, :against => 0, :abstention => 0)
    number_of_votes_should_be(proposal, :in_favor => 1, :against => 0, :abstention => 0)

    login_as @user2
    visit proposal_path(proposal)

    click_button I18n.t(:no_option)
    click_button I18n.t(:i_am_sure)
    visit proposal_path(proposal)

    percentages_should_be(proposal, :in_favor => 50, :against => 50, :abstention => 0)
    number_of_votes_should_be(proposal, :in_favor => 1, :against => 1, :abstention => 0)

    login_as @user3
    visit proposal_path(proposal)
    click_button I18n.t(:abstention)
    click_button I18n.t(:i_am_sure)

    visit proposal_path(proposal)
    percentages_should_be(proposal, :in_favor => 33, :against => 33, :abstention => 33)
    number_of_votes_should_be(proposal, :in_favor => 1, :against => 1, :abstention => 1)

    page.should have_css(".in_favor", :text => "Sí")
    page.should have_css(".against", :text => "No")
    page.should have_css(".abstention", :text => "Abs")
  end

  scenario "Parlament vote results" do
    login_as @user
    proposal = create_proposal(:closed_at => Date.yesterday, :official_resolution => "Aceptada")
    visit proposal_path(proposal)
    page.should have_css(".official_resolution", :text => "Aceptada")
  end

  scenario "Concordance of voter's text and no votes" do
    create_proposal
    visit homepage
    page.should have_content("Sé el primero en votar")
  end

  scenario "Concordance of voter's text and one vote" do
    create_vote
    visit homepage
    page.should have_content("1 persona ya lo ha hecho")
  end

  scenario "Concordance of voter's text and two votes" do
    prop = create_proposal(:title => "Ley ffdsafdsafdsaf")
    create_vote(:user => @user, :proposal => prop)
    create_vote(:user => @user2, :proposal => prop)
    visit homepage
    page.should have_content("2 personas ya lo han hecho")
  end

end
