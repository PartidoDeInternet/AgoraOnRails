class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery

  rescue_from Tractis::InvalidVerificationError do |exception|
    render :text => "Access Denied Bitch", :status => 403
  end
  
  helper :all
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password) }
  end

end
