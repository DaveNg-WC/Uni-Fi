Rails.application.routes.draw do
  resources :partnerships, only: [:index, :new, :create, :destroy]
  resources :budgets
  resources :transactions
  resources :categories
  resources :wallets
  devise_for :users
  root to: "pages#home"
  get '/menu', to: 'pages#menu'
  get '/dashboard', to: 'pages#dashboard'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
