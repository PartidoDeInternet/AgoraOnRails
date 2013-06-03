AgoraOnRails::Application.routes.draw do
  
  devise_for :users
  resources :categories do
    resources :proposals
  end

  resources :proposers do
    resources :proposals
  end
    
  resources :proposals do
    collection do
      get "hot"
      get "closed"
    end
    member do
      post :toggle
    end
    resources :votes
  end

  resource :user_session do
    get 'authenticate'
    post 'create_fake'
  end
  
  resources :users do
    member do
      patch 'choose_as_spokesman'
      patch 'discharge_as_spokesman'
      get 'choose_as_spokesman'
      get 'discharge_as_spokesman'
    end
  end
    
  get '/auth/:provider/callback', :to => 'user_sessions#create', :as => 'callback'

  root :to => "proposals#hot"
end
