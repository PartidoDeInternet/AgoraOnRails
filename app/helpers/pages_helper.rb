module PagesHelper
  
  def users_page?
    controller_name == "users"
  end
  
end