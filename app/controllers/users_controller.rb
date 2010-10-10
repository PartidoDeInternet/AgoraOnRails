class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  layout "mini_application"
  
  def index
    @users = User.all
  end
  
  def new
   @user = User.new
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
  end 
end
