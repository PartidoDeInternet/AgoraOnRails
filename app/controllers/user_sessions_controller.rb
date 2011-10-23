class UserSessionsController < ApplicationController
  include Tractis::IdentityVerifications
  
  before_filter :require_user, :only => :destroy
  layout proc{ |c| c.request.xhr? ? "mini_application" : "application" }
  
  def new
  end
  
  def authenticate
    valid_tractis_identity_verification!(ENV["TRACTIS_API_KEY"], params)
   
    @current_user = User.find_or_create_by_uid(params["tractis:attribute:dni"]) do |user|
      user.provider = "tractis"
      user.name = params["tractis:attribute:name"]
    end
    
    session[:current_user_id] = @current_user.id
    redirect_back_or_default root_url
  end
  
  def create_fake
    name = params[:name].present? ? params[:name] : "Backdoor Mother Fucking Fake User"
    @current_user = User.find_or_create_by_name(name) do |user|
      user.provider = "fake"
      user.uid = name
    end
    
    session[:current_user_id] = @current_user.id
    redirect_back_or_default root_url
  end

  def create
    auth = request.env["omniauth.auth"]
    @current_user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:current_user_id] = @current_user.id
    redirect_back_or_default root_url
  end
  
  def destroy
    session[:current_user_id] = nil
    flash[:notice] = "oh! adios :("
    redirect_to root_path
  end
end
