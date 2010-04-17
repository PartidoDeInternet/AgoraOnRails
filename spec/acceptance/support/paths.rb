module NavigationHelpers
  # Put here the helper methods related to the paths of your applications
  
  def homepage
    "/"
  end
  
  def proposal_path(proposal)
    "/proposals/#{proposal.id}"
  end
  
  def login_path
    "/user_session/new"
  end
  
  def proposal_votes_path(proposal)
    proposal_path(proposal) + "/votes"
  end
end

Spec::Runner.configuration.include(NavigationHelpers)
