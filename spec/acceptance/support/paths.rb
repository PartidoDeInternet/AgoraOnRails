module NavigationHelpers
  def homepage
    "/"
  end
  
  def proposal_path(proposal)
    "#{proposals_path}/#{proposal.id}"
  end
  
  def login_path
    "/users/sign_in"
  end
  
  def proposal_votes_path(proposal)
    proposal_path(proposal) + "/votes"
  end
  
  def proposals_path
    "/proposals"
  end
  
  def user_path(user)
    "#{users_path}/#{user.id}"
  end

  def users_path
    "/users"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
