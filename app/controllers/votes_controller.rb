class VotesController < InheritedResources::Base
  belongs_to :proposal
  before_filter :require_user
  layout "mini_application"
  
  def new
    @proposal = Proposal.find(params[:proposal_id])
    @vote = @proposal.votes.new(params[:vote])
    @vote.user = current_user
    @vote.value = params[:value]
  end
  
  def create
    params[:vote] ||= {}
    params[:vote][:user] = current_user
    create!
  end
end
