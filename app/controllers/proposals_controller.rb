class ProposalsController < InheritedResources::Base
  before_filter :check_is_admin, :only => :toggle

  belongs_to :category, :proposer, :polymorphic => true, :optional => true
  
  helper_method :parent, :parent_type
  
  respond_to :html, :xml

  def show
    @proposal = Proposal.find(params[:id])
    @proposal.visited!
    respond_with(@proposal, :except => [:id, :created_at], :methods => [:proposer_name, :category_name])
  end

  def toggle
    proposal = Proposal.find(params[:id])
    proposal.closed? ? proposal.reopen : proposal.close(current_user.id)
    redirect_to proposal_path(proposal)
  end

  protected

  def check_is_admin
    current_user.is_admin?
  end

  def resource_params
    params.require(:proposal).permit(:title, :official_url, :proposal_type, :category_id, :proposer_id, :proposed_at)
  end
end
