class WelcomeController < ApplicationController
  def index
    @hot_proposals = Proposal.open.hot
  end

end
