module HelperMethods
  def login_as(user)
    visit login_path
    fill_in "Introduce tu DNI", :with => user.dni
    fill_in "Dinos tu contraseña", :with => "secret"
    click_button "Identifícate"
  end
  
  def percentages_should_be(proposal, results)
    visit proposal_path(proposal)
    results.each do |key, value|
      page.should have_css(".#{key}", :text => "#{value}%")
    end
  end
  
  def number_of_votes_should_be(proposal, votes)
    proposal.reload
    votes.each do |key, value|
      proposal.send(key).should == value
    end
  end
  
  def should_see_hot_proposals(titles)
    titles.each do |title|
      page.should have_css("#hot_proposals .proposal .title", :text => title)
    end
  end
  
end

Spec::Runner.configuration.include(HelperMethods)
