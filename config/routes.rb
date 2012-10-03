Management::Application.routes.draw do
  root :to => 'welcome#index'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#login', as: 'login'
  get 'logout', to: 'sessions#logout', as: 'logout'

  resources :users
  resources :entries

end
