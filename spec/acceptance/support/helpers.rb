module HelperMethods
  
  def login_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(user.provider, {:uid => user.uid, :user_info => {:name => user.name}})
    visit "/user_session/new"
    click_link "Sign in with Twitter"
  end

  def login_with_tractis_as(user)
    stub_tractis_request
    get_tractis_callback(user.name, user.uid)
  end

  def register_with_tractis_as(name, dni)
    stub_tractis_request
    get_tractis_callback(name, dni)
  end
  
  def hack_attempt_to_reproduce_tractis_callback
    stub_tractis_not_authorized_request
    visit "/user_session/authenticate?&I_try_to_hack_you=all_your_bases_are_belongs_to_us"
  end
  
  def get_tractis_callback(name, dni)
    visit "/user_session/authenticate?&verification_code=f56dd2d18e490aa9246b993b95d8927e7147c91c&tractis%3Aattribute%3Adni=#{dni}&tractis%3Aattribute%3Aname=#{CGI.escape(name)}&token=f83a65a341853b28c5e0732209433488a0958d04&api_key=36ec6e54ef3e73f61339456abc9d05329afc62b2&tractis%3Aattribute%3Aissuer=DIRECCION+GENERAL+DE+LA+POLICIA"
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
  
  def stub_tractis_not_authorized_request
    stub_request(:post, "https://www.tractis.com/data_verification").
      to_return(:status => 403, :body => "", :headers => {})
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
