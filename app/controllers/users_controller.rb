class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => :choose_as_spokesman
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @proposals = @user.voted_proposals
  end 

end
