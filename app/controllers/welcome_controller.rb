class WelcomeController < ApplicationController
  def index
    @hot_proposals = Proposal.open.hot
    @recently_closed = Proposal.recently_closed
  end

end
