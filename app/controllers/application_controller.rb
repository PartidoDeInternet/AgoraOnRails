class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from Tractis::InvalidVerificationError do |exception|
    render :text => "Access Denied Bitch", :status => 403
  end
  
  helper :all
  helper_method :current_user
  
  private
    def current_user
      return unless session[:current_user_id]
      
      @current_user ||= User.find(session[:current_user_id])
    end
    
    def require_user
      unless current_user
        store_location
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
