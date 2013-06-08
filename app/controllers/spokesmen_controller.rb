class SpokesmenController < ApplicationController
  before_filter :authenticate_user!

  def new
    @spokesman = User.find(params[:id])    
  end
  
  def edit
    @spokesman = User.find(params[:id])
  end
  
  def update
    @spokesman = User.find(params[:id])
    @spokesman_change = current_user.spokesman.present?
    if current_user.update_attributes :spokesman => @spokesman
      render :show
    else
      flash[:alert] = current_user.errors[:spokesman_id].first      
      redirect_to @spokesman, alert: current_user.errors[:spokesman_id].first
    end
  end
  
  def destroy
    spokesman = User.find(params[:id])
    current_user.update_attributes! :spokesman => nil
    redirect_to users_path, :notice => "Has destituido a tu portavoz."
  end
  
end