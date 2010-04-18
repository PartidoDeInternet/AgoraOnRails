class ProposalsController < InheritedResources::Base
  belongs_to :category, :proposer, :polymorphic => true, :optional => true
  
  helper_method :parent, :parent_type
  
  def show
    @proposal = Proposal.find(params[:id])
    @proposal.visits += 1
    @proposal.ranking += 1
    @proposal.save!
    show!
  end
end
