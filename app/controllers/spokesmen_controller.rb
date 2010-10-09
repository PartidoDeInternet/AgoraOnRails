class SpokesmenController < ApplicationController
  before_filter :require_user
  
  def update
    @user = current_user
    spokesman = User.find(params[:id])
    @user.spokesman = spokesman
    @user.save!
    flash[:notice] = "Has elegido a tu portavoz."
    redirect_to spokesman
  end

end
