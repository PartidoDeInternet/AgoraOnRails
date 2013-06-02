class WelcomeController < ApplicationController
  def index
    @title = "Bienvenido"
    @hot = Proposal.hot
    @recently_closed = Proposal.recently_closed
  end

end
