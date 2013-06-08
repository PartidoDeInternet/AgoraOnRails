module SpokesmanHelper
  
  def current_spokesman?(user)
    current_user && current_user.spokesman == user
  end
  
  def has_spokesman?
    current_user && current_user.spokesman.present?
  end
  
  def who_has_delegated?(user)
    if user.represented_users_count.zero?
       t(:be_first_to_delegate)
    else
      pluralize(user.represented_users_count, t(:one_did_it), t(:many_did_it))
    end
  end
  
end