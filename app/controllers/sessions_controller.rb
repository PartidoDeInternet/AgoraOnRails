class SessionsController < Devise::SessionsController
  include Tractis::IdentityVerifications
  layout proc{ |c| c.request.xhr? ? "mini_application" : "application" }
  
  # Refactor with omniauth_callbacks controller
  # by creating a custom tractis ominiauth stategy, inspiration:
  # https://gist.github.com/dira/722793
  def tractis_authentication
    valid_tractis_identity_verification!(ENV["TRACTIS_API_KEY"], params)
    
    request.env["omniauth.auth"] = OmniAuth::AuthHash.new({provider: "tractis", uid: params["tractis:attribute:dni"], info: {nickname: params["tractis:attribute:name"]}})
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else      
      session["devise.user_attributes"] = user.attributes            
      redirect_to new_user_registration_url
    end
  end
end
