module SpokesmanHelper
  
  def current_spokesman?(user)
    current_user && current_user.spokesman == user
  end
  
  def has_spokesman?
    current_user && current_user.spokesman.present?
  end
  
end