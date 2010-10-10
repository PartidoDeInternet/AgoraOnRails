class ProposalsController < InheritedResources::Base
  belongs_to :category, :proposer, :polymorphic => true, :optional => true
  
  helper_method :parent, :parent_type

  def show
    @proposal = Proposal.find(params[:id])
    @proposal.visited!
  end
end
