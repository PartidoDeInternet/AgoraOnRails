class ProposalsController < InheritedResources::Base
  belongs_to :category, :proposer, :polymorphic => true, :optional => true
  
  helper_method :parent, :parent_type

  def show
    @proposal = Proposal.find(params[:id])
    if current_user && current_user.represents_organization?
      @opinion = Opinion.new(:proposal => @proposal, :organization => current_user.represented_organization)
    end 
    @proposal.visited!
  end
end
