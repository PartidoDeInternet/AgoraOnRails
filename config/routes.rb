AgoraOnRails::Application.routes.draw do
  
  resources :categories do
    resources :proposals
  end

  resources :proposers do
    resources :proposals
  end
    
  resources :proposals do
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
    
  get '/auth/twitter/callback', :to => 'user_sessions#create', :as => 'callback'

  root :to => "welcome#index"
end
