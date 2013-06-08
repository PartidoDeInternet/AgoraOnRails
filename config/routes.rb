AgoraOnRails::Application.routes.draw do
  
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", 
                                   sessions: "sessions", registrations: "registrations"}
  devise_scope :user do
    get  'tractis_authentication' => 'sessions#tractis_authentication'
  end

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
  
  resources :users
  resource :spokesman

  root :to => "proposals#hot"
end
