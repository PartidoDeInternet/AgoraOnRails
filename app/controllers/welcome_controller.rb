class WelcomeController < ApplicationController
  def index
    @title = "Bienvenido"
    @staff_choice = Proposal.staff_choice
    @recently_closed = Proposal.recently_closed
  end

end
