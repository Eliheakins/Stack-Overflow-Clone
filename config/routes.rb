Rails.application.routes.draw do
  
  devise_for :users
  resources :users, only: [ :show, :edit, :update, :index ] do
    resources :user_creds, only[ :new, :create]
  end
  put '/user_creds/:id/approve', to: 'user_creds#approve', as: 'user_cred_approve'
  delete '/users/:id', to: 'user_creds#delete', as: 'user_cred'
  resources :replies
  resources :posts
  resources :posts do
    resources :replies, only: [ :new, :create, :edit, :update ]
  end
  resources :tags
  
  resources :home, only: [ :show ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#show"
end
