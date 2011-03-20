class UserSessionsController < ApplicationController
  include Tractis::IdentityVerifications
  
  before_filter :require_user, :only => :destroy
  layout proc{ |c| c.request.xhr? ? "mini_application" : "application" }
  
  def new
  end
  
  def authenticate
    valid_tractis_identity_verification!(ENV["TRACTIS_API_KEY"], params)
   
    @current_user = User.find_or_create_by_dni(params["tractis:attribute:dni"]) do |user|
      user.name = params["tractis:attribute:name"]
    end
    
    session[:current_user_id] = @current_user.id
    redirect_back_or_default root_url
  end
  
  def create
    name = params[:name].present? ? params[:name] : "Backdoor Mother Fucking Fake User"
    @current_user = User.find_or_create_by_name(name) do |user|
      user.dni = "#{rand(99999999)}V"
    end
    
    session[:current_user_id] = @current_user.id
    redirect_back_or_default root_url
  end
  
  def destroy
    session[:current_user_id] = nil
    flash[:notice] = "oh! adios :("
    redirect_to root_path
  end
end
