class VotesController < InheritedResources::Base
  belongs_to :proposal
  before_filter :require_user
    
  def create
    params[:vote] ||= {}
    params[:vote][:user] = current_user
    create!
  end
end
