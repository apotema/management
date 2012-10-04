Management::Application.routes.draw do
  
  mount Doorkeeper::Engine => '/oauth'

  root :to => 'sessions#new'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#login', as: 'login'
  get 'logout', to: 'sessions#logout', as: 'logout'

  namespace :api do
    resources :entries
  end

  resources :users
  resources :entries

end
