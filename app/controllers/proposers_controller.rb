class ProposersController < ApplicationController
  def show
    redirect_to proposer_proposals_path(params[:id])
  end
end
