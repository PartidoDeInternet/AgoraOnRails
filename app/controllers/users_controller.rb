class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :choose_organization
  #before_filter :require_user, :only => [:show, :edit, :update]
  
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
  #
  #def edit
  #  @user = @current_user
  #end
  #
  #def update
  #  @user = @current_user # makes our views "cleaner" and more consistent
  #  if @user.update_attributes(params[:user])
  #    flash[:notice] = "Account updated!"
  #    redirect_to account_url
  #  else
  #    render :action => :edit
  #  end
  #end
  
end
