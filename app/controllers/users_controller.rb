class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => :choose_as_spokesman

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @proposals = @user.voted_proposals
    gon.jbuilder as: :user
  end 

  def edit
  	@user = current_user
  end

  def update
  	redirect_to current_user.tap { |user|
      user.update!(user_params)
    }
  end

  private

  def user_params  
    params.require(:user).permit(:profile_picture, :resume, :languages, :education, :twitter_user, :website_link, :other_link)
  end

end
