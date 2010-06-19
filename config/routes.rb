ActionController::Routing::Routes.draw do |map|
  map.resources :organizations
  map.resources :votes
  map.resources :proposals, :has_many => :votes
  map.resource :user_session
  map.resources :users, :member => {:choose_organization => :put}
  map.resources :categories, :has_many => :proposals
  map.resources :proposers, :has_many => :proposals
  
  map.root :controller => :welcome
end
