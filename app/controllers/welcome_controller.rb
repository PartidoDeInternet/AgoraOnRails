class WelcomeController < ApplicationController
  def index
    @title = "Bienvenido"
    @staff_choice = Proposal.staff_choice
    @recently_closed = Proposal.recently_closed
  end

  def routing_error
    redirect_to root_path
  end
end
