class VotesController < InheritedResources::Base
  belongs_to :proposal
  before_filter :authenticate_user!
  #before_filter :require_user
  layout "mini_application"
  
  def new
    @proposal = Proposal.find(params[:proposal_id])
    @vote = @proposal.votes.new(params[:vote])
    @vote.user = current_user
    @vote.value = params[:value]
  end
  
  def create
    params[:vote] ||= {}
    params[:vote][:user_id] = current_user.id
    create!
  end

  private

  def resource_params
    params.require(:vote).permit(:value, :explanation, :link, :proposal_id, :user_id)
  end
end
