module HelperMethods
  def login_as(user)
    visit login_path
    fill_in "DNI", :with => user.dni
    fill_in "Contraseña", :with => "secret"
    click_button "Identificarse"
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
  
end

Spec::Runner.configuration.include(HelperMethods)
