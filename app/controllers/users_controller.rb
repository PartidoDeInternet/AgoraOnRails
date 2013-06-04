class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => :choose_as_spokesman
  
  def index
    @users = User.all
  end

  def new
   @user = User.new
   render :layout => "mini_application"
  end

  def create
   @user = User.new(params[:user])
   if @user.save
     flash[:notice] = "Registrado :)"
     redirect_back_or_default new_user_session_url
   else
     render :action => :new
   end
  end

  def show
    @user = User.find(params[:id])
    @proposals = @user.voted_proposals
  end 
  
  def choose_as_spokesman
    @spokesman = User.find(params[:id])
    @spokesman_change = current_user.spokesman.present?
    
    if @spokesman_change && !params[:confirmation]
      render :confirm_spokesman_change
    else
      if current_user.update_attributes :spokesman => @spokesman
        render :layout => "mini_application"
      else
        flash[:alert] = current_user.errors[:spokesman_id].first
        redirect_to @spokesman
      end
    end
  end

  def discharge_as_spokesman
    spokesman = User.find(params[:id])
    current_user.update_attributes! :spokesman => nil
    redirect_to spokesman, :notice => "Has destituido a tu portavoz."
  end
end
