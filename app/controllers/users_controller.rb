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
    @proposals = (current_user && current_user == @user) ? @user.voted_proposals : @user.publicly_voted_proposals
  end

  def choose_as_spokesman
    spokesman = User.find(params[:id])
    if current_user.update_attributes :spokesman => spokesman
      render :layout => "mini_application"
    else
      flash[:alert] = current_user.errors[:spokesman_id].first
      redirect_to spokesman
    end
  end

  def discharge_as_spokesman
    spokesman = User.find(params[:id])
    current_user.update_attributes! :spokesman => nil
    redirect_to spokesman, :notice => "Has destituido a tu portavoz."
  end
end
