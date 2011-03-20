module HelperMethods
  def login_as(user)
    stub_tractis_request
    visit "/user_session/authenticate?&verification_code=f56dd2d18e490aa9246b993b95d8927e7147c91c&tractis%3Aattribute%3Adni=#{user.dni}&tractis%3Aattribute%3Aname=#{user.name.parameterize}&token=f83a65a341853b28c5e0732209433488a0958d04&api_key=36ec6e54ef3e73f61339456abc9d05329afc62b2&tractis%3Aattribute%3Aissuer=DIRECCION+GENERAL+DE+LA+POLICIA"
  end

  def percentages_should_be(proposal, results)
    within(:css, "#proposal_#{proposal.id}") do
      results.each do |key, value|
        page.should have_css(".#{key} span.vote_percentage", :text => "#{value}%")
      end
    end
  end
  
  def number_of_votes_should_be(proposal, votes)
    proposal.reload
    votes.each do |key, value|
      proposal.send(key).should == value
    end
  end
  
  def should_see_hot_proposals_in_this_order(titles)
    titles.each_with_index do |title, index|
      page.should have_css("#hot_proposals .proposal:nth-child(#{index + 2}) .title", :text => title)
    end
  end
  
  def stub_tractis_request
    stub_request(:post, "https://www.tractis.com/data_verification").
      to_return(:status => 200, :body => "", :headers => {})
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
