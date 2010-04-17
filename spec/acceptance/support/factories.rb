module Factories
  
  def create_proposal(attrs = {})
    Proposal.create!(attrs)
  end
  
end

Spec::Runner.configuration.include(Factories)