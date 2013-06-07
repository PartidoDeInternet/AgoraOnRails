class RegistrationsController < Devise::RegistrationsController
  before_filter :set_params, only: :create
  
  private
  
  #used to be able to have multiple signin and singnup forms in one page
  def set_params
    params[:user] = params[:account]
  end
end