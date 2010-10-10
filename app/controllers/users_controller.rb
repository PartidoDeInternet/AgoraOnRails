class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :choose_as_spokesman
  
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
    user = current_user
    spokesman = User.find(params[:id])
    user.spokesman = spokesman
    user.save!
    flash[:notice] = "Has elegido a tu portavoz."
    redirect_to spokesman
  end
end
