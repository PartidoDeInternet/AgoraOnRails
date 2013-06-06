class VotesController < InheritedResources::Base
  belongs_to :proposal
  before_filter :authenticate_user!
  
  def new
    @proposal = Proposal.find(params[:proposal_id])
    @vote = @proposal.votes.new(params[:vote])
    @vote.value = params[:value]
  end
  
  def create
    params[:vote] ||= {}
    params[:vote][:user_id] = current_user.id
    create! do |format|
      if error = already_voted?
        format.html { redirect_to @proposal, alert: error.first }
      end
    end
  end
    
  private
    def resource_params
      params.require(:vote).permit(:value, :explanation, :link, :proposal_id, :user_id)
    end
    
    def already_voted?
      @vote.errors.messages[:proposal_id]
    end
    
end
