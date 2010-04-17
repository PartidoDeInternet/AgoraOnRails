module NavigationHelpers
  # Put here the helper methods related to the paths of your applications
  
  def homepage
    "/"
  end
  
  def proposal_path(proposal)
    "/proposals/#{proposal.id}"
  end
end

Spec::Runner.configuration.include(NavigationHelpers)
