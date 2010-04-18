class VotesController < InheritedResources::Base
  belongs_to :proposal
  before_filter :require_user
  
  layout "mini_application"
  
  def new
    store_location
    new!
  end
  
  def create
    params[:vote] ||= {}
    params[:vote][:user] = current_user
    create!
  end
end
