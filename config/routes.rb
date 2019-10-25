Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users do 
    member do
      get :followings
      get :followers
      get :favorites
    end
  end
  resources :products 
  resources :relationships, only: [:create, :destroy]
  resources :favoritelists, only: [:create, :destroy]
end
