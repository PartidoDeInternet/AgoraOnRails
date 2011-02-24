class ProposalsController < InheritedResources::Base
  belongs_to :category, :proposer, :polymorphic => true, :optional => true
  
  helper_method :parent, :parent_type
  
  respond_to :html, :xml

  def show
    @proposal = Proposal.find(params[:id])
    @proposal.visited!
    respond_with(@proposal, :except => [:id, :created_at, :position], :methods => [:proposer_name, :category_name])
  end
end
