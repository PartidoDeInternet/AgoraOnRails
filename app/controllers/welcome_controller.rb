class WelcomeController < ApplicationController
  def index
    @hot_proposals = Proposal.open.hot
    @categories    = Category.hot
  end

end
