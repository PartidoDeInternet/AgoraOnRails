ActionController::Routing::Routes.draw do |map|
  map.resources :opinions

  map.resources :organizations
  map.resources :votes
  map.resources :proposals, :has_many => :votes
  map.resource :user_session
  map.resources :users
  map.resources :categories, :has_many => :proposals
  map.resources :proposers, :has_many => :proposals
  map.resources :spokesmen
  
  map.root :controller => :welcome
end
