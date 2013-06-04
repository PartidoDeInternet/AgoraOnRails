class UserSessionsController < Devise::SessionsController

  include Tractis::IdentityVerifications
  layout proc{ |c| c.request.xhr? ? "mini_application" : "application" }
  
  
  # def authenticate
  #   valid_tractis_identity_verification!(ENV["TRACTIS_API_KEY"], params)
   
  #   random_username = SecureRandom.hex(7)

  #   @current_user = User.find_or_create_by(uid: random_username) do |user|
  #     user.provider = "tractis"
  #     user.name = random_username
  #   end

  #   session[:current_user_name] = params["tractis:attribute:name"]
  #   session[:current_user_id] = @current_user.id
  #   redirect_back_or_default root_url
  # end
  
  # def create_fake
  #   name = params[:name].present? ? params[:name] : "Backdoor Mother Fucking Fake User"
  #   @current_user = User.find_or_create_by(name: name) do |user|
  #     user.provider = "fake"
  #     user.uid = name
  #   end
    
  #   session[:current_user_id] = @current_user.id
  #   redirect_back_or_default root_url
  # end

  # def create
  #   auth = request.env["omniauth.auth"]
  #   @current_user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
  #   session[:current_user_id] = @current_user.id
  #   redirect_back_or_default root_url
  # end
  
  # def destroy
  #   session[:current_user_id] = nil
  #   session[:current_user_name] = nil
  #   flash[:notice] = "oh! adios :("
  #   redirect_to root_path
  # end
end
