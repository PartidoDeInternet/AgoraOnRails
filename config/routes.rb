ActionController::Routing::Routes.draw do |map|
  map.resources :votes

  map.resources :proposals, :has_many => :votes

  map.resource :user_session
  
  map.resources :users
  
  map.home '/', :controller => :proposals, :action => :index
end
